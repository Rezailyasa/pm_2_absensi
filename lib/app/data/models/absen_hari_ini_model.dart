// To parse this JSON data, do
//
//     final absenHariIniModel = absenHariIniModelFromJson(jsonString);

import 'dart:convert';

AbsenHariIniModel absenHariIniModelFromJson(String str) =>
    AbsenHariIniModel.fromJson(json.decode(str));

String absenHariIniModelToJson(AbsenHariIniModel data) =>
    json.encode(data.toJson());

class AbsenHariIniModel {
  bool? success;
  Data? data;
  String? message;

  AbsenHariIniModel({
    this.success,
    this.data,
    this.message,
  });

  factory AbsenHariIniModel.fromJson(Map<String, dynamic> json) =>
      AbsenHariIniModel(
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
  int? id;
  int? usersId;
  String? lokasiUser;
  DateTime? waktuAbsenMasuk;
  dynamic waktuAbsenPulang;
  DateTime? tanggalHariIni;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.usersId,
    this.lokasiUser,
    this.waktuAbsenMasuk,
    this.waktuAbsenPulang,
    this.tanggalHariIni,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        usersId: json["users_id"],
        lokasiUser: json["lokasi_user"],
        waktuAbsenMasuk: json["waktu_absen_masuk"] == null
            ? null
            : DateTime.parse(json["waktu_absen_masuk"]),
        waktuAbsenPulang: json["waktu_absen_pulang"],
        tanggalHariIni: json["tanggal_hari_ini"] == null
            ? null
            : DateTime.parse(json["tanggal_hari_ini"]),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "users_id": usersId,
        "lokasi_user": lokasiUser,
        "waktu_absen_masuk": waktuAbsenMasuk?.toIso8601String(),
        "waktu_absen_pulang": waktuAbsenPulang,
        "tanggal_hari_ini":
            "${tanggalHariIni!.year.toString().padLeft(4, '0')}-${tanggalHariIni!.month.toString().padLeft(2, '0')}-${tanggalHariIni!.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
