import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
//
import 'package:health/models/added_medicine.dart';
import 'package:health/services/local_notification.dart';

class AddMedicineController extends GetxController {
  final pillNameController = TextEditingController();
  final durationDayController = '0';
  RxBool isTrue = false.obs;
  RxString selectedHour = '00'.obs;
  RxString selectedMinute = '00'.obs;
  RxString selectedAmPm = 'AM'.obs;
  RxInt selectedHourIndex = (-1).obs;
  RxInt selectedAmPmIndex = (-1).obs;
  RxInt countMedicine = 0.obs;
  late String pillName;
  late String durationDay;
  RxList<AddedMedicine> addedMedicineData = <AddedMedicine>[].obs;
  List<String> hourList = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
  List<String> amPmList = ['AM', 'PM'];

  //AddMedicineController() {}

  void saveData() async {
    pillName = pillNameController.text;
    durationDay = durationDayController;
    // print(pillName);
    // print(durationDay);
    // print(selectedHour);
    // print(selectedAmPm);
    if (pillName.isEmpty) {
      await Fluttertoast.showToast(msg: 'Name of pill is required');
      //print('Name of pill is required');
    } else if (durationDay.isEmpty) {
      await Fluttertoast.showToast(msg: 'Number of days is required');
      //print('Number of days is required');
    } else if (selectedHour.value == '00') {
      await Fluttertoast.showToast(msg: 'valid time is required');
    } else {
      try {
        LocalNotificationService.displayNotification(
          day: durationDay,
          hour: selectedHour.value,
          minute: selectedMinute.value,
          pillName: pillName,
          countMedicine: countMedicine.value.toString(),
        );
        final addingMedicine = AddedMedicine(name: pillName, addedTime: selectedHour.value);
        bool isExisting = addedMedicineData.any((model) => model.addedTime == addingMedicine.addedTime);
        if (!isExisting) {
          addedMedicineData.add(addingMedicine);
        } else {
          for (var model in addedMedicineData) {
            if (model.addedTime == addingMedicine.addedTime) {
              model.name = addingMedicine.name;
            }
          }
        }
        //print(addedMedicineData);
        await Fluttertoast.showToast(msg: 'added reminder...');
        // Get.offAllNamed(HomeScreenView.routeName,arguments: addedMedicineData);
        Get.back(result: addedMedicineData);
      } catch (error) {
        await Fluttertoast.showToast(msg: 'Something went wrong!');
      }
    }
  }

  void selectTime() async {
    final pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      selectedHour.value = pickedTime.hour.toString();
      selectedMinute.value = pickedTime.minute.toString();
      selectedAmPm.value = pickedTime.format(Get.context!).split(' ')[1];
    }
    //String demo = pickedTime!.format(context);
  }

  void selectHour(int index) {
    selectedHourIndex.value = index;
    selectedHour.value = hourList[index];
  }

  void selectAmPm(int index) {
    selectedAmPmIndex.value = index;
    selectedAmPm.value = amPmList[index];
  }

  void toggleIsTrue() {
    isTrue.value = !isTrue.value;
  }

  void addMedicine() {
    countMedicine = countMedicine + 1;
  }

  void removeMedicine() {
    countMedicine = countMedicine - 1;
    if (countMedicine < 0) {
      countMedicine.value = 0;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    print('remider screen..');
    super.onInit();
  }
}
