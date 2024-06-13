import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pm_2_absensi/app/modules/profile/controllers/profile_model.dart';
import 'package:pm_2_absensi/app/routes/app_pages.dart';

import '../../../style/app_color.dart';
import '../../../widget/custom_bottom_navigation_bar.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: FutureBuilder<ProfileModel>(
        future: controller.getUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              var data = snapshot.data;
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 36),
                children: [
                  const SizedBox(height: 16),
                  // section 1 - profile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 124,
                          height: 124,
                          color: Colors.blue,
                          child: Image.network(
                            "https://ui-avatars.com/api/?name=${data!.data!.name}/",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 4),
                        child: Text(
                          data.data!.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        data.data!.email!,
                        style: TextStyle(color: AppColor.secondarySoft),
                      ),
                    ],
                  ),
                  // section 2 - menu
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 42),
                    child: Column(
                      children: [
                        MenuTile(
                          title: 'Change Password',
                          icon: const Icon(Icons.password),
                          onTap: () =>
                              Get.toNamed(Routes.CHANGE_PASSWORD, arguments: {
                            'email': data.data!.email!,
                          }),
                        ),
                        MenuTile(
                          isDanger: true,
                          title: 'Sign Out',
                          icon: const Icon(Icons.logout_rounded),
                          onTap: controller.authC.logout,
                        ),
                        Container(
                          height: 1,
                          color: AppColor.primaryExtraSoft,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      (isDanger == false) ? AppColor.secondary : AppColor.error,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:
                    (isDanger == false) ? AppColor.secondary : AppColor.error,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
