import 'dart:async';
import 'dart:io';

import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/feature/florist/repository/orders_repository.dart';
import 'package:flutter_boilerplate/feature/florist/state/one_order_state.dart';
import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final oneOrderProvider =
    StateNotifierProvider<OneOrderProvider, OneOrderState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return OneOrderProvider(ref.read, appStartState);
});

class OneOrderProvider extends StateNotifier<OneOrderState> {
  OneOrderProvider(this._reader, this._appStartState)
      : super(const OneOrderState.loading()) {
    _init();
  }
  String? _orderId;
  final Reader _reader;
  final AppStartState _appStartState;
  late final OrdersRepository _repository = _reader(orderRepositoryProvider);
  Timer? _timer;

  Future<void> _init() async {
    _appStartState.when(
        floristAuthenticated: () {
          if(_orderId!=null){
            getOrderById(_orderId!);
            initTimer(_orderId!);
          }
        },
        shipperAuthenticated: () {
          if(_orderId!=null){
            getOrderById(_orderId!);
            initTimer(_orderId!);
          }
        },
        adminAuthenticated: (){
          //TODO: implement admin init
        },
        unauthenticated: () {
          _timer?.cancel();
        },
        internetUnAvailable: () {},
        initial: () {});
  }

  Future<void> updateStatusOrder(
      String orderId, String newStatus,int version,String? accountId,{GpsModel? gpsModel}) async {
    final response = await  _repository.updateStatusOrder(orderId, newStatus,version,accountId,gpsModel:gpsModel);
    mappingOrderResponse(response);
  }

  Future<void> changeStatusToDone(
      String status, String orderId,int version, List<File> files,String accountId,{GpsModel? gpsModel}) async {
    await addListImageToOrder(orderId, files);
    changeOrderStatus(orderId, status,version,accountId,gpsModel:gpsModel);
  }

  Future<void> addListImageToOrder(String orderId, List<File> files) async {
    changeOneOrderStateToLoading(); //loading
    final futures = files.map((e) {
      return addImageToOrder(orderId, e);
    });
    final urls = await Future.wait(futures);
    //TODO:
  }

  Future<String?> addImageToOrder(String orderId, File file) async {
    final url = await uploadOneImage(file);
    if (url != null) {
      final attachmentId = await createAttachment(url);
      if (attachmentId != null) {
        final attachmentIds = List.filled(1, attachmentId, growable: false);
        await _repository.addImageToOrder(orderId, attachmentIds);

        return url;
      }
    }

    return null;
  }

  Future<void> deleteImage(String attachmentId) async {
    changeOneOrderStateToLoading();
    await _repository.deleteImage(attachmentId);
    if(_orderId!=null)await getOrderById(_orderId!);
  }

  Future<String?> createAttachment(String url) async {
    final urlRes = await _repository.createAttachment(url);

    return urlRes;
  }

  Future<String?> uploadOneImage(File file) async {
    final url = await _repository.uploadImage(file);

    return url;
  }

  Future<void> getOrderById(String orderId) async {
    _orderId = orderId;
    if(_timer==null){initTimer(orderId);}
    final order = await _repository.getOrderById(orderId);
    await order.maybeWhen(error: (error) async {
      if (error is AppExceptionUnauthorized) {
        _timer?.cancel();
        if (_timer != null) await _reader(homeProvider.notifier).logout();
        _timer = null;
        _orderId=null;
      }
    },
        orderLoaded: (Order order){
          if(order.status== OrderStatus.SALE_REJECTED.name){
            _timer?.cancel();
            UiUtil.showAlertAppException("Cảnh báo","Đơn này đã bị Sale từ chối, vui lòng cập nhật và dừng làm đơn này");
          }
          if(order.status == OrderStatus.DONE.name){
            _timer?.cancel();
          }
        }
    ,orElse: (){});
    mappingOrderResponse(order);
  }

  void changeOrderStatus(String orderId, String currentStatus,int version,String? accountId,{GpsModel? gpsModel}) {
    if (currentStatus == OrderStatus.NEW.name) {
      updateStatusOrder(orderId, OrderStatus.DOING.name,version,accountId,gpsModel:gpsModel);
    } else if (currentStatus == OrderStatus.DOING.name||currentStatus==OrderStatus.CUSTOMER_REJECTED.name) {
      updateStatusOrder(orderId, OrderStatus.DONE.name,version,accountId,gpsModel:gpsModel);
    }
    else if (currentStatus == OrderStatus.CUSTOMER_SATISFIED.name) {
      updateStatusOrder(orderId, OrderStatus.SHIPPING.name,version,accountId,gpsModel: gpsModel);
    }else if(currentStatus == OrderStatus.SHIPPING.name){
      updateStatusOrder(orderId, OrderStatus.SHIPPED_WITH_PAYMENT.name,version,accountId,gpsModel: gpsModel);
    }
  }
 void changeOneOrderStateToLoading(){
    if(mounted){
      state= const OneOrderState.loading();
    }
 }
  OneOrderState mappingOrderResponse(OneOrderState orderState) {

    orderState.when(
        orderLoaded: (order) {
          if (mounted) {
            state = orderState;
          }
        },
        loading: () {},
        error: (error){
          UiUtil.showAppException(error);
        },
    );

    return state;
  }
  Future<void> createComment(
      {required String orderId,
        required String content,
        required List<XFile>? files}) async {
    final fileList =
    files != null ? files.map((e) => File(e.path)).toList() : [];
    final readFiles = fileList.whereType<File>();
    final features = readFiles.map(_repository.uploadImage);
    final urls = await Future.wait(features);
    final realListUrls = urls.whereType<String>().toList();
    final attachmentsIds =
    await Future.wait(realListUrls.map(_repository.createAttachment));
    await _repository.createComment(
        orderId: orderId, content: content, attachments: attachmentsIds.whereType<String>().toList());
    await getOrderById(orderId);
  }

  Future<void> updateCommentById(
      {required String orderId,
        required String commentId,
        required String content,
        required List<File> files}) async {
    await _repository.updateCommentById(
        orderId: orderId,
        content: content,
        attachments: [],
        commentId: commentId);
  }

  Future<void> deleteCommentById(
      {required String orderId, required String commentId}) async {
    await _repository.deleteCommentById(orderId: orderId, commentId: commentId);
  }
  Timer initTimer(String orderId) {
    if (_timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
        getOrderById(orderId);
        if (_appStartState is Unauthenticated) {
          _timer?.cancel();
        }
      });
    }

    return _timer!;
  }
  void cancelTimer(){
    // if(mounted){
    //   state=const OneOrderState.loading();
    // }
    _timer?.cancel();
    _timer=null;
  }
}
