// To parse this JSON data, do
//
//     final absenHistoryModel = absenHistoryModelFromJson(jsonString);

import 'dart:convert';

AbsenHistoryModel absenHistoryModelFromJson(String str) =>
    AbsenHistoryModel.fromJson(json.decode(str));

String absenHistoryModelToJson(AbsenHistoryModel data) =>
    json.encode(data.toJson());

class AbsenHistoryModel {
  bool? success;
  List<Datum>? data;
  String? message;

  AbsenHistoryModel({
    this.success,
    this.data,
    this.message,
  });

  factory AbsenHistoryModel.fromJson(Map<String, dynamic> json) =>
      AbsenHistoryModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  int? usersId;
  String? lokasiUser;
  String? waktuAbsenMasuk;
  dynamic waktuAbsenPulang;
  String? tanggalHariIni;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        usersId: json["users_id"],
        lokasiUser: json["lokasi_user"],
        waktuAbsenMasuk: json["waktu_absen_masuk"],
        waktuAbsenPulang: json["waktu_absen_pulang"],
        tanggalHariIni: json["tanggal_hari_ini"],
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
        "waktu_absen_masuk": waktuAbsenMasuk,
        "waktu_absen_pulang": waktuAbsenPulang,
        "tanggal_hari_ini": tanggalHariIni,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
