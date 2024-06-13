import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pm_2_absensi/app/data/models/absen_hari_ini_model.dart';
import 'package:pm_2_absensi/app/data/models/absen_history_model.dart';

import '../../../routes/app_pages.dart';
import '../../../style/app_color.dart';
import '../../../widget/custom_bottom_navigation_bar.dart';
import '../../../widget/presence_card.dart';
import '../../../widget/presence_tile.dart';
import '../../profile/controllers/profile_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      extendBody: true,
      body: FutureBuilder<ProfileModel>(
          future: controller.getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                var user = snapshot.data!;
                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                  children: [
                    const SizedBox(height: 16),
                    // Section 1 - Welcome Back
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          ClipOval(
                            child: SizedBox(
                              width: 42,
                              height: 42,
                              child: Image.network(
                                "https://ui-avatars.com/api/?name=${user.data!.name}/",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "welcome back",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.secondarySoft,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.data!.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // section 2 -  card
                    FutureBuilder<AbsenHariIniModel>(
                        future: controller.getCekAbsenHariIni(),
                        builder: (context, snapshot) {
                          // #TODO: make skeleton
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              var todayPresenceData = snapshot.data;
                              return PresenceCard(
                                userData: user,
                                todayPresenceData: todayPresenceData,
                              );
                            default:
                              return const SizedBox();
                          }
                        }),

                    const SizedBox(height: 16),
                    // section 3 distance & map
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 84,
                              decoration: BoxDecoration(
                                color: AppColor.primaryExtraSoft,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: const Text(
                                      'Distance from office',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.officeDistance.value,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.launchOfficeOnMap,
                              child: Container(
                                height: 84,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryExtraSoft,
                                  borderRadius: BorderRadius.circular(8),
                                  // image: const DecorationImage(
                                  //   image: AssetImage('assets/images/map.JPG'),
                                  //   fit: BoxFit.cover,
                                  //   opacity: 0.3,
                                  // ),
                                ),
                                child: const Text(
                                  'Open in maps',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Section 4 - Presence History
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Presence History",
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.ABSEN),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColor.primary,
                          ),
                          child: const Text("show all"),
                        ),
                      ],
                    ),
                    FutureBuilder<AbsenHistoryModel>(
                        future: controller.getAbsenHistory(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.data!.data == null ||
                                  snapshot.data!.data == []) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              var listPresence = snapshot.data!;
                              return ListView.separated(
                                itemCount: listPresence.data!.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  return PresenceTile(
                                    presenceData: listPresence,
                                    index: index,
                                  );
                                },
                              );
                            default:
                              return const SizedBox();
                          }
                        }),
                  ],
                );

              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                return const Center(child: Text("Error"));
            }
          }),
    );
  }
}
