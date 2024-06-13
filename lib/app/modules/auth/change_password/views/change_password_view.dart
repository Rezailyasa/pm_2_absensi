import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../style/app_color.dart';
import '../../../../widget/custom_input.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Obx(
            () => CustomInput(
              controller: controller.currentPassC,
              label: 'Old Password',
              hint: '*************',
              obsecureText: controller.oldPassObs.value,
              suffixIcon: IconButton(
                icon: (controller.oldPassObs.isTrue)
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  controller.oldPassObs.value = !(controller.oldPassObs.value);
                },
              ),
            ),
          ),
          Obx(
            () => CustomInput(
              controller: controller.newPassC,
              label: 'New Password',
              hint: '******************',
              obsecureText: controller.newPassObs.value,
              suffixIcon: IconButton(
                icon: (controller.newPassObs.isTrue)
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  controller.newPassObs.value = !(controller.newPassObs.value);
                },
              ),
            ),
          ),
          Obx(
            () => CustomInput(
              controller: controller.confirmNewPassC,
              label: 'Confirm New Password',
              hint: '******************',
              obsecureText: controller.newPassCObs.value,
              suffixIcon: IconButton(
                icon: (controller.newPassCObs.isTrue)
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  controller.newPassCObs.value =
                      !(controller.newPassCObs.value);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    if (controller.currentPassC.text.isNotEmpty &&
                        controller.newPassC.text.isNotEmpty &&
                        controller.confirmNewPassC.text.isNotEmpty) {
                      if (controller.newPassC.text ==
                          controller.confirmNewPassC.text) {
                        await controller.changePassword(
                          email: Get.arguments['email']!,
                          currentPassword: controller.currentPassC.text,
                          newPassword: controller.newPassC.text,
                        );
                      } else {
                        Get.rawSnackbar(
                          message:
                              'new password and confirm password doesnt match',
                          backgroundColor: AppColor.error,
                        );
                      }
                    } else {
                      Get.rawSnackbar(
                        message: 'all form must be filled',
                        backgroundColor: AppColor.error,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  (controller.isLoading.isFalse)
                      ? "Change Password"
                      : 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
