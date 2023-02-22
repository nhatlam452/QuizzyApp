import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/custom_text_style.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:booking_app/controller/question_paper/queston_controller.dart';
import 'package:booking_app/screens/question/test_overview_screen.dart';
import 'package:booking_app/widgets/common/background_decoration,dart.dart';
import 'package:booking_app/widgets/common/custom_app_bar.dart';
import 'package:booking_app/widgets/common/main_button.dart';
import 'package:booking_app/widgets/common/screen_placeholder.dart';
import 'package:booking_app/widgets/content_area.dart';
import 'package:booking_app/widgets/question/answert_card.dart';
import 'package:booking_app/widgets/question/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);
  static const String routeName = "/question_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: onSurfaceTextColor, width: 2))),
            child: Obx(()=>CountdownTimer(time: controller.time.value,color: onSurfaceTextColor,)),
          ),
          showActionIcons: true,
          titleWidget: Obx(() => Text(
                'Question ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: appBarTS,
              ))),
      body: BackgroundDercoration(
        child: Obx(() => Center(
                child: Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                      child: ContentArea(child: ScreenPlaceHolder())),
                if (controller.loadingStatus.value == LoadingStatus.complete)
                  Expanded(
                      child: ContentArea(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: questionTextStyle,
                            ),
                            GetBuilder<QuestionController>(
                                id: 'answer_list',
                                builder: (context) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 25),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers[index];
                                      return AnswerCard(
                                        answer:
                                            '${answer.identifier}. ${answer.answer}',
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: 20,
                                    ),
                                    itemCount: controller
                                        .currentQuestion.value!.answers.length,
                                  );
                                }),
                          ],
                        )),
                  )),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Visibility(
                            visible: controller.isFirstQuestion,
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: MainButton(
                                onTap: () {
                                  controller.previousQuestion();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Get.isDarkMode
                                      ? onSurfaceTextColor
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            )),
                        Expanded(
                          child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.complete,
                              child: MainButton(
                                onTap: () {
                                  controller.isLastQuestion
                                      ? Get.toNamed(TestOverViewScreen.routeNamed)
                                      : controller.nextQuestion();
                                },
                                title: controller.isLastQuestion
                                    ? 'Complete'
                                    : 'Next',
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
