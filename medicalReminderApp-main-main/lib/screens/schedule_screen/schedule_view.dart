import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
//
import 'package:health/screens/schedule_screen/controller/schedule_controller.dart';
import 'package:health/models/added_medicine.dart';
import 'package:health/resources/app_colors.dart';
import 'package:health/resources/app_images.dart';

class ScheduleView extends StatelessWidget {
  ScheduleView({super.key});

  static const routeName = '/ScheduleView';

  static Widget builder(BuildContext context) {
    final addedMedicineDataList = Get.arguments;
    return GetBuilder<ScheduleController>(
      init: ScheduleController(addedMedicineDataList),
      builder: (controller) {
        return ScheduleView();
      },
    );
  }

  final scheduleController = Get.find<ScheduleController>();
  final String currentDate = DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(color: AppColors.lightGrey, spreadRadius: 0, blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$currentDate\n',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.grey,
                                ),
                              ),
                              const TextSpan(
                                text: 'Расписание',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    //color: Colors.red,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            scheduleController.selectIndex(index);
                          },
                          child: Obx(
                            () {
                              DateTime currentDate2 = DateTime.now().add(Duration(days: index));
                              String day = DateFormat('EEE').format(currentDate2);
                              String date = DateFormat('dd').format(currentDate2);
                              return Container(
                                width: 60,
                                margin: const EdgeInsets.only(
                                  left: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: scheduleController.selectedIndex.value == index ? AppColors.appOrange : AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '$day\n',
                                          style: TextStyle(
                                            fontSize: 16,
                                            //fontWeight: FontWeight.bold,
                                            color: scheduleController.selectedIndex.value == index ? AppColors.white : AppColors.grey,
                                          ),
                                        ),
                                        TextSpan(
                                          text: date,
                                          style: TextStyle(
                                            fontSize: 14,
                                            //fontWeight: FontWeight.bold,
                                            color: scheduleController.selectedIndex.value == index ? AppColors.white : AppColors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: scheduleController.times.length,
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              scheduleController.times[index],
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.lightGrey2),
                            ),
                            Expanded(
                              child: Container(
                                height: 70,
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(color: const Color.fromARGB(255, 245, 215, 200), borderRadius: BorderRadius.circular(10)),
                                child: showText(index, scheduleController.addedMedicineDataList),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(color: AppColors.lightGrey, spreadRadius: 5, blurRadius: 5, offset: Offset(0, 0)),
            ],
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: scheduleController.dayWeek.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      scheduleController.selectedDayWeek(index);
                    },
                    child: Obx(
                      () {
                        return Text(
                          scheduleController.dayWeek[index],
                          style: scheduleController.selectedDayWeek.value == index
                              ? const TextStyle(color: AppColors.appOrange, fontSize: 18)
                              : const TextStyle(color: AppColors.grey, fontSize: 18),
                        );
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.lightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //elevation: 3
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 27,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget showText(int index, List<AddedMedicine> medicineData) {
  String textData = 'Нет активности';
  for (int i = 0; i < medicineData.length; i++) {
    int hour = int.parse(medicineData[i].addedTime!);
    if (hour == 1 && index == 0) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 2 && index == 1) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 3 && index == 2) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 4 && index == 3) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 5 && index == 4) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 6 && index == 5) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 7 && index == 6) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 8 && index == 7) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 9 && index == 8) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 10 && index == 9) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 11 && index == 10) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 0 && index == 11) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 13 && index == 12) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 14 && index == 13) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 15 && index == 14) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 16 && index == 15) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 17 && index == 16) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 18 && index == 17) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 19 && index == 18) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 20 && index == 19) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 21 && index == 20) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 22 && index == 21) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 23 && index == 22) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    } else if (hour == 24 && index == 23) {
      return Text(
        medicineData[i].name.toString(),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      );
    }
  }
  return Text(
    textData,
    style: const TextStyle(fontSize: 16, color: AppColors.lightGrey2),
  );
}
