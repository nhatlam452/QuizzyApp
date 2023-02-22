import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

enum AnswerStatus{
  correct,wrong,answered,not
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard(
      {Key? key,
      required this.answer,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color:
              isSelected ? answerSelectedColor() : Theme.of(context).cardColor,
          border: Border.all(
              color: isSelected ? answerSelectedColor() : answerBorderColor()),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({Key? key, required this.ans}) : super(key: key);
  final String ans;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnsColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Text(
        ans,
        style: TextStyle(
          color: correctAnsColor, fontWeight: FontWeight.bold
        ),

      ),
    );
  }
}
class WrongAnswer extends StatelessWidget {
  const WrongAnswer({Key? key, required this.ans}) : super(key: key);
  final String ans;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnsColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Text(
        ans,
        style: TextStyle(
          color: wrongAnsColor, fontWeight: FontWeight.bold
        ),

      ),
    );
  }
}
class NotAnswer extends StatelessWidget {
  const NotAnswer({Key? key, required this.ans}) : super(key: key);
  final String ans;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: notAnsColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Text(
        ans,
        style: TextStyle(
          color: notAnsColor, fontWeight: FontWeight.bold
        ),

      ),
    );
  }
}
