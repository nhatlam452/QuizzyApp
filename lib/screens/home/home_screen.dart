
import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/custom_text_style.dart';
import 'package:booking_app/controller/question_paper/question_paper_controller.dart';
import 'package:booking_app/controller/zoom_drawer_controller.dart';
import 'package:booking_app/screens/home/question_card.dart';
import 'package:booking_app/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_icon.dart';
import '../../configs/themes/ui_parameters.dart';
import 'menu_screen.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            borderRadius: 50.0,
            moveMenuScreen: false,
            menuScreen: MenuScreen(),
            controller: _.zoomDrawerController,
            menuScreenWidth: double.maxFinite,
            angle: 0.0,
            style: DrawerStyle.defaultStyle,
            slideWidth: MediaQuery.of(context).size.width*0.65,
            mainScreen: Container(
              decoration: BoxDecoration(
                  gradient: mainGradient()),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: controller.toggleDrawer,
                            child: const Icon(
                              AppIcons.menuLeft,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  AppIcons.peace,
                                ),
                                Text(
                                  "Hello , friend",
                                  style: detailText.copyWith(
                                      color: onSurfaceTextColor),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "What do you want to learn today?",
                            style: headerText,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(() => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext content, int index) {
                                return QuestionCard(
                                    model: _questionPaperController
                                        .allPaper[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount:
                              _questionPaperController.allPaper.length)),
                        ),
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
  }
}
