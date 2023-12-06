import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/notification/model/notify_model.dart';
import 'package:flutter_boilerplate/shared/constants/app_theme.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:get/get.dart';

class UiUtil {
  static void showAppException(AppException ae) {
    ae.mapOrNull(
      errorWithMessage: (value) {
        Get.snackbar(
          'Lỗi',
          value.message,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      },
    );
  }
  static void showAppNotification(NotifyModel notification) {
        Get.snackbar(
          'Thông báo: ',
          '${notification.message}',
          snackPosition: SnackPosition.TOP,
          colorText: AppColors.background,
          backgroundColor: AppColors.primary,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
    );
  }
  static void showSuccessMessage(String message) {
        Get.snackbar(
          'Thông báo: ',
          '${message}',
          snackPosition: SnackPosition.TOP,
          colorText: AppColors.background,
          backgroundColor: AppColors.primary,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
    );
  }
  static void showAppExceptionFromBottom(AppException ae) {
    ae.mapOrNull(
      errorWithMessage: (value) {
        Get.snackbar(
          'Lỗi',
          value.message,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      },
    );
  }
  static void  showAlertAppException(String title,String message){
        Get.dialog(
          AlertDialog(
            title:  Text(title),
            content:  Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.all(14),
                  child: const Text("Đồng ý",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        );
  }
  static void showNormalAlert(String title,String message,VoidCallback onSucess){
    Get.dialog(
      AlertDialog(
        title:  Text(title),
        content:  Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onSucess();
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Đồng ý",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Huỷ bỏ",style: TextStyle(color: Colors.grey),),
            ),
          ),
        ],
      ),
    );
  }
}
