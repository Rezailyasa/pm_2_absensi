import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absen_history_controller.dart';

class AbsenHistoryView extends GetView<AbsenHistoryController> {
  const AbsenHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AbsenHistoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AbsenHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
