import 'package:booking_app/configs/themes/custom_text_style.dart';
import 'package:booking_app/controller/question_paper/queston_controller.dart';
import 'package:booking_app/widgets/common/background_decoration,dart.dart';
import 'package:booking_app/widgets/common/custom_app_bar.dart';
import 'package:booking_app/widgets/content_area.dart';
import 'package:booking_app/widgets/question/answert_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerCheckScreen extends GetView<QuestionController> {
  const AnswerCheckScreen({Key? key}) : super(key: key);
  static const String routedNamed = "/answerScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text(
              'question'.tr + '${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
              style: appBarTS,
            )),
        showActionIcons: true,
        onMenuActionTap: () {},
      ),
      body: BackgroundDercoration(
        child: Obx(() => Column(
              children: [
                Expanded(
                    child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(controller.currentQuestion.value!.question),
                        GetBuilder<QuestionController>(
                            id: 'answer_review_list',
                            builder: (_) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) {
                                    final ans = controller
                                        .currentQuestion.value!.answers[index];
                                    final _selectedAns = controller
                                        .currentQuestion.value!.selectedAnswer;
                                    final _correctAns = controller
                                        .currentQuestion.value!.correctAnswer;

                                    final String ansText =
                                        '${ans.identifier}. ${ans.answer}';
                                    if (_correctAns == _selectedAns &&
                                        ans.identifier == _selectedAns) {
                                      return CorrectAnswer(ans: ansText);
                                    } else if (_selectedAns == null) {
                                      return NotAnswer(ans: ansText);
                                    } else if (_correctAns != _selectedAns &&
                                        ans.identifier == _selectedAns) {
                                      return WrongAnswer(ans: ansText);
                                    } else if (_correctAns == ans.identifier) {
                                      return CorrectAnswer(ans: ansText);
                                    }
                                    return AnswerCard(
                                      answer: ansText,
                                      onTap: () {},
                                      isSelected: false,
                                    );
                                  },
                                  separatorBuilder: (_, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: controller
                                      .currentQuestion.value!.answers.length);
                            })
                      ],
                    ),
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
