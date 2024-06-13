import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pm_2_absensi/app/data/API/profile_api.dart';

import '../../../../data/controller/auth_controller.dart';

class ChangePasswordController extends GetxController {
  final authC = Get.find<AuthController>();

  RxBool isLoading = false.obs;
  TextEditingController currentPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  RxBool oldPassObs = true.obs;
  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      var res = await ProfileApi().changePassword(
        accesstoken: authC.currentToken!,
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      isLoading.value = false;
      if (res.data['success'] == true) {
        Get.back();
        Get.rawSnackbar(
          messageText: Text(res.data['message']),
          backgroundColor: Colors.green.shade300,
        );
      } else {
        Get.rawSnackbar(
          messageText: Text(res.data['message'].toString()),
          backgroundColor: Colors.red.shade300,
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        messageText: Text(e.toString()),
        backgroundColor: Colors.red.shade300,
      );
    }
  }
}
