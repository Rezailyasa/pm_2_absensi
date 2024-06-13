// To parse this JSON data, do
//
//     final profilPerusahaanModel = profilPerusahaanModelFromJson(jsonString);

import 'dart:convert';

ProfilPerusahaanModel profilPerusahaanModelFromJson(String str) =>
    ProfilPerusahaanModel.fromJson(json.decode(str));

String profilPerusahaanModelToJson(ProfilPerusahaanModel data) =>
    json.encode(data.toJson());

class ProfilPerusahaanModel {
  bool? success;
  Data? data;
  String? message;

  ProfilPerusahaanModel({
    this.success,
    this.data,
    this.message,
  });

  factory ProfilPerusahaanModel.fromJson(Map<String, dynamic> json) =>
      ProfilPerusahaanModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  String? namaPerusahaan;
  String? latitude;
  String? longitude;
  String? deskripsi;
  String? jamMasuk;
  String? jamPulang;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.namaPerusahaan,
    this.latitude,
    this.longitude,
    this.deskripsi,
    this.jamMasuk,
    this.jamPulang,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        namaPerusahaan: json["nama_perusahaan"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deskripsi: json["deskripsi"],
        jamMasuk: json["jam_masuk"],
        jamPulang: json["jam_pulang"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama_perusahaan": namaPerusahaan,
        "latitude": latitude,
        "longitude": longitude,
        "deskripsi": deskripsi,
        "jam_masuk": jamMasuk,
        "jam_pulang": jamPulang,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
