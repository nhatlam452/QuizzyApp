import 'dart:async';

import 'package:booking_app/controller/auth_controller.dart';
import 'package:booking_app/controller/question_paper/question_paper_controller.dart';
import 'package:booking_app/controller/question_paper/result_controller.dart';
import 'package:booking_app/firebase_ref/references.dart';
import 'package:booking_app/models/question_paper_model.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/screens/question/answer_check.dart';
import 'package:booking_app/screens/question/result_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';

class QuestionController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaper questionPaperModel;
  final allQuestion = <Questions>[];
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  final questionIndex = 0.obs;

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get isLastQuestion => questionIndex.value >= allQuestion.length - 1;

  //Timer
  Timer? _timer;

  int remainSeconds = 1;
  final time = "00.00".obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaper;
    loadData(_questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaper questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
      await questionPaperRF
          .doc(questionPaper.id)
          .collection("questions")
          .get();
      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();
      questionPaper.questions = questions;
      for (Questions _question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
        await questionPaperRF
            .doc(questionPaper.id)
            .collection("questions")
            .doc(_question.id)
            .collection("answers")
            .get();
        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestion.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.complete;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answer_list']);
  }

  void jumpToQuestion(int index, {bool isBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestion[index];
    if (isBack) {
      Get.back();
    } else {
      Get.toNamed(AnswerCheckScreen.routedNamed);
    }
  }

  String get completedText {
    final asw = allQuestion
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$asw out of ${allQuestion.length} answered";
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestion.length - 1) {
      return;
    }
    questionIndex.value++;
    currentQuestion.value = allQuestion[questionIndex.value];
  }

  void previousQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestion[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = minutes.toString().padLeft(2, "0") + ":" +
            seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeNamed);
  }

  void tryAgain() {
    Get.find<QuestionPaperController>().navigateToQuestion(
        paper: questionPaperModel, tryAgain: true);
  }


  void navigateToHome(){
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }


}
