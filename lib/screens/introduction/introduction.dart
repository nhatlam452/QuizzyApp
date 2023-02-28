import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class AppIntroduction extends StatelessWidget {
  const AppIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String slogan =
        "slogan".tr;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 65,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                slogan,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: onSurfaceTextColor),
              ),
              SizedBox(
                height: 40,
              ),
              AppCircleButton(
                onTap: () => Get.offAndToNamed("/home"),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
