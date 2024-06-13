import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_color.dart';
import '../data/controller/page_index_controller.dart';

class CustomBottomNavigationBar extends GetView<PageIndexController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 67,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.secondaryExtraSoft, width: 1),
                ),
              ),
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(0),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 0)
                                    ? const Icon(Icons.home)
                                    : const Icon(Icons.home_outlined),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      margin: const EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: Text(
                        "Presence",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(2),
                        child: SizedBox(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: (controller.pageIndex.value == 2)
                                    ? const Icon(Icons.person)
                                    : const Icon(Icons.person_outline),
                              ),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            child: SizedBox(
              width: 64,
              height: 64,
              child: Obx(() => FloatingActionButton(
                    onPressed: () => controller.changePage(1),
                    elevation: 0,
                    child: (controller.present.isLoading.isFalse)
                        ? const Icon(Icons.fingerprint)
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
