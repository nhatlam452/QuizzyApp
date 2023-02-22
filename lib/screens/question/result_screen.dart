
import 'package:booking_app/controller/question_paper/queston_controller.dart';
import 'package:booking_app/controller/question_paper/result_controller.dart';
import 'package:booking_app/widgets/common/background_decoration,dart.dart';
import 'package:booking_app/widgets/common/custom_app_bar.dart';
import 'package:booking_app/widgets/common/main_button.dart';
import 'package:booking_app/widgets/content_area.dart';
import 'package:booking_app/widgets/question/answert_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_style.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widgets/question/quesion_number_card.dart';

class ResultScreen extends GetView<QuestionController> {
  const ResultScreen({Key? key}) : super(key: key);
  static const String routeNamed = '/rsScreen';

  @override
  Widget build(BuildContext context) {
    Color _color = Get.isDarkMode ?Colors.white:Theme.of(context).primaryColor;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar:  CustomAppBar(
          leading: const SizedBox(
            height: 80,
          ),
          title: controller.correctAnsQuestions,
        ),
        body: BackgroundDercoration(
          child: Column(
            children: [

              Expanded(child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                     Padding(
                       padding: const EdgeInsets.only(top: 20 , bottom: 5),
                       child: Text("Congratulation",
                       style: headerText.copyWith(color: _color),),
                     ),
                    Text("You have ${controller.points} point",
                    style: TextStyle(color: _color),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Tap bellow question numbers to view correct answers',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(child: GridView.builder(
                      itemCount: controller.allQuestion.length,
                      shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width~/75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8
                        ),
                        itemBuilder: (_,index){
                        final _question = controller.allQuestion[index];
                        AnswerStatus _status = AnswerStatus.not;
                        final _selectedAns = _question.selectedAnswer;
                        final _correctAns = _question.correctAnswer;
                        if(_selectedAns == _correctAns){
                          _status = AnswerStatus.correct;
                        }else if(_question.selectedAnswer==null){
                          _status = AnswerStatus.wrong;
                        }else{
                          _status = AnswerStatus.wrong;
                        }
                        return QuestionNumberCard(
                          index : index,
                          status: _status,
                          onTap: (){
                            controller.jumpToQuestion(index,isBack: false);
                          },
                        );
                        }))
                  ],
                ),
              )),
              ColoredBox(color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(onTap: (){
                        controller.tryAgain();
                      },
                      color: Colors.blueGrey,
                        title: 'Try again',
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: MainButton(onTap: (){
                        controller.saveTextRs();

                      },
                        title: 'Go home',
                      ),
                    )
                  ],
                ),
              ),)
            ],
          ),
        )

    );
  }
}
