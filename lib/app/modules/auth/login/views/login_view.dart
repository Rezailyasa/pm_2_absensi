import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../style/app_color.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 35 / 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32),
            decoration: BoxDecoration(
              gradient: AppColor.primaryGradient,
              // image: const DecorationImage(
              //   image: AssetImage('assets/images/pattern-1-1.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Smart Present App",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    height: 150 / 100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Pemrograman Mobile 2",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 65 / 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.authC.emailC,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 14,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "youremail@email.com",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: Obx(
                    () => TextField(
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                      maxLines: 1,
                      controller: controller.authC.passwordC,
                      obscureText: controller.authC.obsecureText.value,
                      decoration: InputDecoration(
                        label: Text(
                          "Password",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            fontSize: 14,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none,
                        hintText: "*************",
                        suffixIcon: IconButton(
                          icon: (controller.authC.obsecureText.isTrue)
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            controller.authC.obsecureText.value =
                                !(controller.authC.obsecureText.value);
                          },
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondarySoft,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.authC.isLoading.isFalse) {
                          await controller.authC.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: AppColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        (controller.authC.isLoading.isFalse)
                            ? 'Log in'
                            : 'Loading...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.secondarySoft,
                        ),
                        child: const Text("Forgot your password?"),
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => Get.toNamed(Routes.REGISTER),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.secondarySoft,
                        ),
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
