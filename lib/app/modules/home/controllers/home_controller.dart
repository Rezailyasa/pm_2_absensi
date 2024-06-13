import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:pm_2_absensi/app/data/API/presence_api.dart';
import 'package:pm_2_absensi/app/data/controller/auth_controller.dart';
import 'package:pm_2_absensi/app/data/models/absen_hari_ini_model.dart';
import 'package:pm_2_absensi/app/data/models/absen_history_model.dart';

import '../../../data/API/profile_api.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/toast/custom_toast.dart';
import '../../profile/controllers/profile_model.dart';

class HomeController extends GetxController {
  final authC = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  RxString officeDistance = "-".obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    //cek setiap 10 detik lokasi posisinya dimana
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (Get.currentRoute == Routes.HOME) {
        getDistanceToOffice().then((value) {
          officeDistance.value = value;
        });
      }
    });
  }

  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        double.parse(authC.profilPerusahaanModel.data!.latitude!),
        double.parse(authC.profilPerusahaanModel.data!.longitude!),
      );
    } catch (e) {
      CustomToast.errorToast('Error', 'Error : $e');
    }
  }

  Future<String> getDistanceToOffice() async {
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      double distance = Geolocator.distanceBetween(
        double.parse(authC.profilPerusahaanModel.data!.latitude!),
        double.parse(authC.profilPerusahaanModel.data!.longitude!),
        position.latitude,
        position.longitude,
      );
      if (distance > 1000) {
        return "${(distance / 1000).toStringAsFixed(2)}km";
      } else {
        return "${distance.toStringAsFixed(2)}m";
      }
    } else {
      return "-";
    }
  }

  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.rawSnackbar(
        title: 'GPS is off',
        message: 'you need to turn on gps',
        duration: const Duration(seconds: 3),
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message":
              "Tidak dapat mengakses karena anda menolak permintaan lokasi",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location permissions are permanently denied, we cannot request permissions.",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }

  ProfileModel profileModel = ProfileModel();

  Future<ProfileModel> getUser() async {
    try {
      var res = await ProfileApi().getProfile(
        accesstoken: authC.currentToken!,
      );
      if (res.data['success'] == true) {
        profileModel = ProfileModel.fromJson(res.data);
        return profileModel;
      } else {
        Get.rawSnackbar(
          messageText: Text(res.data['message'].toString()),
          backgroundColor: Colors.red.shade300,
        );
        return profileModel;
      }
    } catch (e) {
      Get.rawSnackbar(
        messageText: Text(e.toString()),
        backgroundColor: Colors.red.shade300,
      );
      return profileModel;
    }
  }

  Future<AbsenHariIniModel> getCekAbsenHariIni() async {
    try {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      var res = await PresenceApi().cekAbsenHariIni(
        accesstoken: authC.currentToken!,
        usersId: authC.currentUsersId!,
        waktuHariIni: formatted,
      );
      if (res.data['success'] == true) {
        authC.absenHariIniModel = AbsenHariIniModel.fromJson(res.data);
        return authC.absenHariIniModel;
      } else {
        Get.rawSnackbar(
          messageText: Text(res.data['message'].toString()),
          backgroundColor: Colors.red.shade300,
        );
        return authC.absenHariIniModel;
      }
    } catch (e) {
      Get.rawSnackbar(
        messageText: Text(e.toString()),
        backgroundColor: Colors.red.shade300,
      );
      return authC.absenHariIniModel;
    }
  }

  AbsenHistoryModel absenHistoryModel = AbsenHistoryModel();
  Future<AbsenHistoryModel> getAbsenHistory() async {
    try {
      var res = await PresenceApi().absenHistory(
        accesstoken: authC.currentToken!,
        usersId: authC.currentUsersId!,
      );
      if (res.data['success'] == true) {
        absenHistoryModel = AbsenHistoryModel.fromJson(res.data);
        return absenHistoryModel;
      } else {
        Get.rawSnackbar(
          messageText: Text(res.data['message'].toString()),
          backgroundColor: Colors.red.shade300,
        );
        return absenHistoryModel;
      }
    } catch (e) {
      Get.rawSnackbar(
        messageText: Text(e.toString()),
        backgroundColor: Colors.red.shade300,
      );
      return absenHistoryModel;
    }
  }
}
