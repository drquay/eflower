import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/florist/state/one_order_state.dart';
import 'package:flutter_boilerplate/feature/florist/state/orders_state.dart';
import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

abstract class OrdersRepositoryProtocol {
  Future<OrdersState> fetchOrders();

  Future<OneOrderState> updateStatusOrder(
      String orderId, String newStatus, int version, String? accountId,
      {GpsModel? gpsModel});

  Future<OrdersState> fetchOrdersByStatus(String status);

  Future<String?> uploadImage(File file);

  Future<String?> createAttachment(String url);

  Future<void> addImageToOrder(String orderId, List<String> ids);

  Future<OneOrderState?> getOrderById(String orderId);

  Future<void> deleteImage(String attachmentId);

  Future<void> createComment(
      {required String orderId,
      required String content,
      required List<String> attachments});

  Future<void> updateCommentById(
      {required String orderId,
      required String commentId,
      required String content,
      required List<String> attachments});

  Future<void> deleteCommentById(
      {required String orderId, required String commentId});
}

final orderRepositoryProvider = Provider((ref) => OrdersRepository(ref.read));

class OrdersRepository implements OrdersRepositoryProtocol {
  OrdersRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<OrdersState> fetchOrders() async {
    final response =
        await _api.get('orders?sortBy=deliveryDateTime&ascDirection=0');

    response.when(
      success: (success) {},
      error: (error) {
        return OrdersState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final _orderRes = orderResponse(value);

        return OrdersState.ordersLoaded(_orderRes);
      } catch (e) {
        return OrdersState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return OrdersState.error(response.exception);
    } else {
      return const OrdersState.loading();
    }
  }

  @override
  Future<OrdersState> fetchOrdersByStatus(String status) async {
    final response = await _api
        .get('orders?status=$status&sortBy=deliveryDateTime&ascDirection=0');
    response.when(
      success: (success) {},
      error: (error) {
        return OrdersState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final _orderRes = orderResponse(value);

        return OrdersState.ordersLoaded(_orderRes);
      } catch (e) {
        return OrdersState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return OrdersState.error(response.exception);
    } else {
      return const OrdersState.loading();
    }
  }

  @override
  Future<OneOrderState> updateStatusOrder(
      String orderId, String newStatus, int version, String? accountId,
      {GpsModel? gpsModel}) async {
    final params = {'status': newStatus, 'version': version};
    if (gpsModel != null) {
      params['toLongitude'] = gpsModel.longitude;
      params['toLatitude'] = gpsModel.latitude;
      if (gpsModel.numberOfKm != null)
        params['numberOfKm'] = gpsModel.numberOfKm!.toDouble();
    }

    final updateResponse = await _api.put('orders/$orderId/statuses', params);
    if (updateResponse is APISuccess) {
      if (accountId != null) {
        await _api.put('orders/$orderId/re-assigned?accountId=$accountId', {});
      }
    }
    final response = await _api.get('orders/$orderId'); //fetch order
    response.when(
      success: (success) {},
      error: (error) {
        return OrdersState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final _order = orderFromJson(value);

        return OneOrderState.orderLoaded(_order);
      } catch (e) {
        return OneOrderState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return OneOrderState.error(response.exception);
    } else {
      return const OneOrderState.loading();
    }
  }

  @override
  Future<String?> uploadImage(File file) async {
    final fileName = basename(file.path);
    Map<String, MultipartFile> multipartFiles = {};
    multipartFiles['file'] =
        MultipartFile(file.openRead(), await file.length(), filename: fileName);
    final formData = FormData.fromMap(multipartFiles);

    final response = await _api.post('', formData,
        newBaseUrl: dotenv.env['UPLOAD_IMAGE_URL']!,
        contentType: ContentType.multipart);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final imageUrl = value['link'];

        return imageUrl;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<String?> createAttachment(String url) async {
    final params = {
      'url': url,
      'img': url,
      'name': url,
    };
    final response = await _api.post('attachments', params);
    if (response is APISuccess) {
      final value = response.value;
      try {
        final id = value['id'];
        return id;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  @override
  Future<void> addImageToOrder(String orderId, List<String> ids) async {
    final response = await _api.post('orders/$orderId/images', ids);
  }

  @override
  Future<OneOrderState> getOrderById(String orderId) async {
    final response = await _api.get('orders/$orderId');
    if (response is APISuccess) {
      final value = response.value;
      try {
        final order = Order.fromJson(value);
        order.comments.sort((a, b) => b.createdOn.compareTo(a.createdOn));
        return OneOrderState.orderLoaded(order);
      } catch (e) {
        return OneOrderState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return OneOrderState.error(
          AppException.errorWithMessage(response.exception.toString()));
    } else {
      return const OneOrderState.loading();
    }
  }

  @override
  Future<void> deleteImage(String attachmentId) async {
    final response = await _api.delete('attachments/$attachmentId');
    if (response is APIError) {
      if (kDebugMode) {
        print(response.exception);
      }
    }
  }

  @override
  Future<void> createComment(
      {required String orderId,
      required String content,
      required List<String> attachments}) async {
    final body = {'content': content, 'attachmentIds': attachments};
    final response = await _api.post('orders/$orderId/comments', body);
    print(response);
  }

  @override
  Future<void> updateCommentById(
      {required String orderId,
      required String commentId,
      required String content,
      required List<String> attachments}) async {
    final body = {'attachmentIds': attachments, 'content': content};
    final response =
        await _api.put('orders/{$orderId}/comments/{$commentId}', body);
  }

  @override
  Future<void> deleteCommentById(
      {required String orderId, required String commentId}) async {
    final response =
        await _api.delete('orders/{$orderId}/comments/{$commentId}');
  }

// @override
// Future<OrdersState> orderStatistic() async {
//   final response = await _api.get('reports/order-statistic');
//   response.when(
//     success: (success) {},
//     error: (error) {
//       return OrdersState.error(error);
//     },
//   );
// }
}
