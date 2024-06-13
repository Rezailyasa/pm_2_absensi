import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pm_2_absensi/app/data/models/absen_history_model.dart';
import '../routes/app_pages.dart';
import '../style/app_color.dart';

class PresenceTile extends StatelessWidget {
  final AbsenHistoryModel presenceData;
  final int index;
  const PresenceTile(
      {super.key, required this.index, required this.presenceData});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.ABSEN, arguments: presenceData),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding:
            const EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "check in",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (presenceData.data![index].waktuAbsenMasuk == null)
                          ? "-"
                          : DateFormat.jms().format(DateTime.parse(presenceData
                              .data![index].waktuAbsenMasuk!
                              .toString())),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "check out",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      (presenceData.data![index].waktuAbsenPulang == null)
                          ? "-"
                          : DateFormat.jms().format(DateTime.parse(presenceData
                              .data![index].waktuAbsenPulang!
                              .toString())),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.parse(
                  presenceData.data![index].tanggalHariIni!.toString())),
              style: TextStyle(
                fontSize: 10,
                color: AppColor.secondarySoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
