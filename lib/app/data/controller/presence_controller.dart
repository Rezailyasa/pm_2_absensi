import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pm_2_absensi/app/data/API/presence_api.dart';
import 'package:pm_2_absensi/app/data/controller/auth_controller.dart';
import 'package:pm_2_absensi/app/routes/app_pages.dart';
import 'package:pm_2_absensi/app/widget/toast/custom_toast.dart';

import '../../widget/dialog/custom_alert_dialog.dart';

class PresenceController extends GetxController {
  RxBool isLoading = false.obs;
  final authC = Get.find<AuthController>();
  //-6.3817734
  //107.0994255

  presence() async {
    isLoading.value = true;
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      double distance = Geolocator.distanceBetween(
          double.parse(authC.profilPerusahaanModel.data!.latitude!),
          double.parse(authC.profilPerusahaanModel.data!.longitude!),
          position.latitude,
          position.longitude);
      // print(position);
      // print(address);
      // print(distance);
      // presence ( store to database )
      if (distance < 300) {
        //cek data sudah absen masuk atau belum
        if (authC.absenHariIniModel.data == null) {
          CustomAlertDialog.showPresenceAlert(
            title: "Are you want to check in?",
            message: "you need to confirm before you\ncan do presence now",
            onCancel: () => Get.back(),
            onConfirm: () async {
              await processPresence(position, address, distance);
            },
          );
        } else {
          CustomAlertDialog.showPresenceAlert(
            title: "Are you want to check out?",
            message: "you need to confirm before you\ncan do presence now",
            onCancel: () => Get.back(),
            onConfirm: () async {
              await processPresencePulang(
                  authC.absenHariIniModel.data!.id.toString());
            },
          );
        }
      } else {
        CustomToast.errorToast(
            'Tidak bisa absen', 'Lokasi kamu lebih dari 200 meter dari kantor');
      }
      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi kesalahan", determinePosition["message"]);
      // print(determinePosition["error"]);
    }
  }

  Future<void> processPresence(
      Position position, String address, double distance) async {
    try {
      isLoading.value = true;
      var res = await PresenceApi().absenMasuk(
        accesstoken: authC.currentToken!,
        usersId: authC.currentUsersId!,
        lokasi: address,
        waktuAbsenMasuk: DateTime.now().toString(),
      );
      isLoading.value = false;
      if (res.data['success'] == true) {
        Get.back();
        CustomToast.successToast("Success", res.data['message'].toString());
      } else {
        Get.rawSnackbar(
          messageText: Text(res.data['message'].toString()),
          backgroundColor: Colors.red.shade300,
        );
      }
    } catch (error) {
      isLoading.value = false;
      Get.rawSnackbar(message: error.toString());
    }
  }

  Future<void> processPresencePulang(String id) async {
    try {
      isLoading.value = true;
      var res = await PresenceApi().absenPulang(
        accesstoken: authC.currentToken!,
        id: id,
        waktuAbsenPulang: DateTime.now().toString(),
      );
      isLoading.value = false;
      if (res.data['success'] == true) {
        Get.back();
        CustomToast.successToast("Success", res.data['message'].toString());
      } else {
        Get.rawSnackbar(
          messageText: Text(res.data['message'].toString()),
          backgroundColor: Colors.red.shade300,
        );
      }
    } catch (error) {
      isLoading.value = false;
      Get.rawSnackbar(message: error.toString());
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
}
