import 'package:get/get.dart';

import '../controllers/absen_history_controller.dart';

class AbsenHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsenHistoryController>(
      () => AbsenHistoryController(),
    );
  }
}
