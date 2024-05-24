import 'package:get/get.dart';
import 'package:health/models/added_medicine.dart';

class ScheduleController extends GetxController{
  RxInt selectedIndex = 0.obs;
  RxInt selectedDayWeek = 0.obs;
  RxList<String> dayWeek = ['Day','Week'].obs;
  RxList<String> times = ['01 AM','02 AM','03 AM','04 AM','05 AM','06 AM','07 AM','08 AM','09 AM','10 AM','11 AM','12 AM','01 PM','02 PM','03 PM','04 PM','05 PM','06 PM','07 PM','08 PM','09 PM','10 PM','11 PM','12 PM'].obs;
  RxList<AddedMedicine> addedMedicineDataList = <AddedMedicine>[].obs;

  ScheduleController(RxList<AddedMedicine>? addedMedicineData){
    if(addedMedicineData != null){
      addedMedicineDataList = addedMedicineData;
      print(addedMedicineDataList);
      print('not null');
    } else{
      print('null');
    }
  }

  void selectIndex(int index){
    selectedIndex.value = index;
  }

  void selectDayWeek(int index){
    selectedDayWeek.value = index;
  }
}