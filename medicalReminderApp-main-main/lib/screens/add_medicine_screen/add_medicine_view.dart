import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/screens/Add_medicine_screen/controller/add_medicine_controller.dart';
import 'package:health/screens/home_screen/home_screen_view.dart';
import '../../resources/app_images.dart';
import '../../resources/app_colors.dart';
//import '../../services/local_notification.dart';

class AddMedicineView extends StatelessWidget {
  AddMedicineView({super.key});

  static const routeName = '/AddMedicineView';

  static Widget builder(BuildContext context) {
    return GetBuilder<AddMedicineController>(
      init: AddMedicineController(),
      builder: (controller) {
        return AddMedicineView();
      },
    );
  }

  final addMedicineController = Get.find<AddMedicineController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //Navigator.of(context).pop();
                    //Navigator.of(context).pushReplacementNamed(HomeScreenView.routeName);
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.leftArrow,
                    height: 35,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Добавьте свою\n",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Повседневную медицину\n',
                            style: TextStyle(
                              fontSize: 17,
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'И установите свой график',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      AppImages.medicine2,
                      height: 135,
                    ),
                  ],
                ),
                const Text(
                  'Название таблетки',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.lightBlack),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 5),
                  child: TextField(
                    controller: addMedicineController.pillNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'парацетамол, 20 г.',
                      hintStyle: const TextStyle(color: AppColors.grey, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.grey,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Количество\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Сколько таблеток нужно принять один раз?\n',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        onPressed: () {
                          addMedicineController.removeMedicine();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.appOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //elevation: 3
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 25,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Obx(
                        () => Text(
                          '${addMedicineController.countMedicine} Таблетки',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        onPressed: () {
                          addMedicineController.addMedicine();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.appOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //elevation: 3
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 25,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Время\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Добавьте время, когда вам нужно принять таблетки.\n',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Obx(
                            () {
                              return Text(
                                '${addMedicineController.selectedHour}   :   ${addMedicineController.selectedMinute}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightBlack,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextButton(
                          onPressed: () {
                            //addMedicineController.toggleIsTrue();
                            addMedicineController.selectTime();
                          },
                          child: const Text(
                            '+ Добавить время',
                            style: TextStyle(color: AppColors.appOrange, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.linen,
                        ),
                        child: const Icon(
                          Icons.schedule_rounded,
                          size: 30,
                          color: AppColors.appOrange,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          height: 55,
                          child: TextButton(
                            onPressed: () {
                              addMedicineController.saveData();
                              //LocalNotificationService.displayNotification();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.appOrange,
                              shadowColor: AppColors.appOrange,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //elevation: 3
                            ),
                            child: const Text(
                              'Добавить таблетки',
                              style: TextStyle(color: AppColors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
