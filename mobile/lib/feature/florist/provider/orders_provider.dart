import 'dart:async';

import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/feature/florist/repository/orders_repository.dart';
import 'package:flutter_boilerplate/feature/florist/state/orders_state.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersProvider extends StateNotifier<OrdersState> {
  OrdersProvider(this._reader, this._appStartState, this._statuses)
      : super(const OrdersState.loading()) {
    _init();
  }

  final List<String> _statuses;
  final Reader _reader;
  final AppStartState _appStartState;
  late final OrdersRepository _repository = _reader(orderRepositoryProvider);
  Timer? _timer;
  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);
  Token? token ;
  Future<void> _init() async {
    _appStartState.when(
        floristAuthenticated: () {
          fetchOrders();
          initTimer();
        },
        shipperAuthenticated: () {
          fetchOrders();
          initTimer();
        },
        adminAuthenticated: () {
          //TODO: Admin
        },
        unauthenticated: () {
          _timer?.cancel();
        },
        internetUnAvailable: () {},
        initial: () {},
      );
  }

  Future<void> fetchOrders() async {
    OrderResponse listOrder =
        OrderResponse(totalPages: 0, totalItems: 0, currentPage: 0, items: []);
    if (_statuses.isEmpty) {
      final response = await _repository.fetchOrders();
      await response.maybeWhen(
          error: (error) async {
            if (error is AppExceptionUnauthorized) {
              _timer?.cancel();
              if (_timer != null) await _reader(homeProvider.notifier).logout();
              _timer = null;
            }
          },
          ordersLoaded: (orders) async {
            final floristFilterList = await filterOrderForFlorist(orders.items);
            List<Order> items = List.of(floristFilterList);
            items.addAll(listOrder.items);
            listOrder = OrderResponse(
                totalPages: orders.totalPages,
                totalItems: listOrder.totalItems + items.length,
                currentPage: orders.currentPage,
                items: items);
          },
          orElse: () {});
    }
    for (final status in _statuses) {
      final response = await _repository.fetchOrdersByStatus(status);
      await response.maybeWhen(
          error: (error) async {
            if (error is AppExceptionUnauthorized) {
              if (_timer != null) await _reader(homeProvider.notifier).logout();
              _timer?.cancel();
            }
          },
          ordersLoaded: (OrderResponse orderResponse) async {
            final floristFilterList =
                await filterOrderForFlorist(orderResponse.items);
            List<Order> items = List.of(floristFilterList);
            items.addAll(listOrder.items);
            listOrder = OrderResponse(
                totalPages: orderResponse.totalPages,
                totalItems: items.length,
                currentPage: orderResponse.currentPage,
                items: items);
          },
          orElse: () {});
    }
    if (mounted) {
      state = OrdersState.ordersLoaded(listOrder);
    }
    // final response = await _repository.fetchOrders();
    // response.maybeWhen(
    //     error: (error) {
    //       if (error is AppExceptionUnauthorized) {
    //         _reader(homeProvider.notifier).logout();
    //       }
    //     },
    //     orElse: () {});
  }

  // Future<void> _fetchOrdersDefault() async {
  //   final response = await _repository.fetchOrders();
  //   await response.maybeWhen(
  //       error: (error) async {
  //         if (error is AppExceptionUnauthorized) {
  //           if(_timer!=null) await _reader(homeProvider.notifier).logout();
  //           _timer?.cancel();
  //         }
  //       },
  //       orElse: () {});
  //   if (mounted) {
  //     state = response;
  //   }
  // }

  Timer initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
        fetchOrders();
        if (_appStartState is Unauthenticated) {
          _timer?.cancel();
        }
      });
    }

    return _timer!;
  }

  Future<List<Order>> filterOrderForFlorist(List<Order> originOrder) async {
    List<Order> finalOrder = List.empty(growable: true);
    if (!_statuses.contains(OrderStatus.NEW.name)) {
      token ??= await _tokenRepository.fetchToken();
      if (token != null && token!.privileges.contains(Privilege.FLORIST_PRIVILEGE.name)) {
        for (final order in originOrder) {
          order.assignmentHistories
              .sort((a, b) => a.createdOn.compareTo(b.createdOn));
          if (order.assignmentHistories.last.personInCharse.username ==
              token!.username) {
            finalOrder.add(order);
          }
        }

        return finalOrder;
      }
    }

    return originOrder;
  }
}
