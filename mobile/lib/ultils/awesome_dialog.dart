import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AwesomeDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    String cancelText = 'Cancel',
    VoidCallback? onCancel,
    String? route,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) {
                onConfirm();
              } else if (route != null) {
                Navigator.pushNamed(context, route); // Navigate to the specified route
              }
            },
            child: Text(confirmText),
          ),
          TextButton(
            onPressed: onCancel ?? () => Get.back(),
            child: Text(cancelText),
          ),
        ],
      ),
    );
  }
}