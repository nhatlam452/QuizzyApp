import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:booking_app/controller/question_paper/queston_controller.dart';
import 'package:booking_app/screens/home/question_card.dart';
import 'package:booking_app/widgets/common/background_decoration,dart.dart';
import 'package:booking_app/widgets/common/custom_app_bar.dart';
import 'package:booking_app/widgets/common/main_button.dart';
import 'package:booking_app/widgets/content_area.dart';
import 'package:booking_app/widgets/question/answert_card.dart';
import 'package:booking_app/widgets/question/countdown_timer.dart';
import 'package:booking_app/widgets/question/quesion_number_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestOverViewScreen extends GetView<QuestionController> {
  static const String routeNamed = "/testoverview";

  const TestOverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: controller.completedText),
      body: BackgroundDercoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                          time: '',
                          color: UIParameters.isDarkMode()
                              ? Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .color
                              : Theme
                              .of(context)
                              .primaryColor,
                        ),
                        Obx(() =>
                            Text(
                              '${controller.time} Remaining',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: UIParameters.isDarkMode()
                                      ? Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color
                                      : UIParameters.isDarkMode()
                                      ? Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color
                                      : Theme
                                      .of(context)
                                      .primaryColor,
                                  letterSpacing: 2),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                          itemCount: controller.allQuestion.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.width ~/ 75,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                          itemBuilder: (_, index) {
                            AnswerStatus? _ansStatus;
                            if (controller.allQuestion[index].selectedAnswer !=
                                null) {
                              _ansStatus = AnswerStatus.answered;
                            }
                            return QuestionNumberCard(
                                index: index,
                                status: _ansStatus,
                                onTap: () => controller.jumpToQuestion(index));
                          }),
                    )
                  ],
                ),
              ),
            ),
            ColoredBox(color: Theme
                .of(context)
                .scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: MainButton(
                  onTap: () {
                    controller.complete();
                  },
                  title: 'Complete',
                ),
              ),)
          ],
        ),
      ),
    );
  }
}
