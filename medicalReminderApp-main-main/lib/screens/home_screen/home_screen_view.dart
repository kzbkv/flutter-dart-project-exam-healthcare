import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health/models/added_medicine.dart';
import 'package:health/screens/auth/auth_service.dart';
import 'package:health/screens/auth/login/login_screen.dart';
import '../../resources/app_images.dart';
import '../../resources/app_colors.dart';
import 'controller/home_controller.dart';

class HomeScreenView extends StatefulWidget {
  HomeScreenView({super.key});

  static const routeName = '/HomeScreenView';

  static Widget builder(BuildContext context) {
    //final addedMedicineData = Get.arguments;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        // controller.onInit();
        return HomeScreenView();
      },
    );
  }

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int pageIndex = 0;

  // void initState() {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: pageIndex == 1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Наши сервисы:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.lightBlack),
                          ),
                        ),
                        Container(
                          height: 170,
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          //color: Colors.red,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeController.serviceList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  homeController.navigateToNewScreen(homeController.serviceList[index]['name']);
                                },
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 20),
                                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColors.lightGrey,
                                          blurRadius: 6,
                                          spreadRadius: 5,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        homeController.serviceList[index]['imagePath'],
                                        height: 60,
                                      ),
                                      Text(
                                        homeController.serviceList[index]['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'Есть жалобы сегодня?',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.lightBlack),
                        ),
                        Container(
                          height: 170,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.lightGrey),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: 'Объясните подробности..',
                                  hintStyle: TextStyle(color: AppColors.grey),
                                  suffix: Text(
                                    '0/250',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      shadowColor: AppColors.grey,
                                      elevation: 2,
                                      backgroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      //elevation: 3
                                    ),
                                    child: const Text(
                                      'Отправить жалобы',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.appOrange),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : pageIndex == 0
                      ? Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  child: Image(
                                    image: AssetImage(AppImages.userIcon),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Aibek Kazbek',
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 3,
                              child: Container(
                                height: 250,
                                width: 300,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                                child: const Padding(
                                  padding: EdgeInsets.all(40.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Возраст: 20 лет',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Text(
                                        'Пол: Идентифицирует себя как вертолет',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Text(
                                        'Рост: 191',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Text(
                                        'Вес: 110',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                    await AuthService().deleteToken();
                                  },
                                  child: Container(
                                    height: 65,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Text('Выход'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey,
                  spreadRadius: 0,
                  blurRadius: 7,
                )
              ]),
          height: 90,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: Obx(
              () {
                return BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 0,
                  onTap: (indexValue) {
                    setState(() {
                      pageIndex = indexValue;
                    });
                    homeController.selectIndex(indexValue);
                  },
                  type: BottomNavigationBarType.fixed,
                  currentIndex: pageIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: CircleAvatar(
                            radius: 25,
                            backgroundColor: homeController.selectedIndex.value == 0 ? AppColors.appOrange : Colors.transparent,
                            child: SvgPicture.asset(AppImages.profile,
                                height: 25,
                                colorFilter: homeController.selectedIndex.value == 0
                                    ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                                    : const ColorFilter.mode(AppColors.grey, BlendMode.srcIn))),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: CircleAvatar(
                            radius: 25,
                            backgroundColor: homeController.selectedIndex.value == 1 ? AppColors.appOrange : Colors.transparent,
                            child: SvgPicture.asset(
                              AppImages.home,
                              height: 25,
                              colorFilter: homeController.selectedIndex.value == 1
                                  ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                                  : const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                            )),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: CircleAvatar(
                            radius: 25,
                            backgroundColor: homeController.selectedIndex.value == 2 ? AppColors.appOrange : Colors.transparent,
                            child: SvgPicture.asset(
                              AppImages.more,
                              height: 25,
                              colorFilter: homeController.selectedIndex.value == 2
                                  ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                                  : const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                            )),
                        label: ''),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
