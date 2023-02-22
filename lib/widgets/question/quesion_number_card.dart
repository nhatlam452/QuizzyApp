import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:booking_app/widgets/question/answert_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionNumberCard extends StatelessWidget {
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  const QuestionNumberCard(
      {Key? key,
      required this.index,
      required this.status,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        _backgroundColor:
        Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        _backgroundColor = correctAnsColor;
        break;
      case AnswerStatus.wrong:
        _backgroundColor = wrongAnsColor;
        break;
      case AnswerStatus.not:
        _backgroundColor = Get.isDarkMode?Colors.red.withOpacity(0.5):Theme.of(context).primaryColor
        .withOpacity(0.1);

        break;
      default:
        _backgroundColor = Theme.of(context).primaryColor
            .withOpacity(0.1);
    }
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        child: Center(
          child: Text(
            '${index+1}',
            style: TextStyle(
              color: status==AnswerStatus.not?Theme.of(context).primaryColor:null
            ),
          ),
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: UIParameters.cardBorderRadius
        ),
      ),
    );
  }
}
