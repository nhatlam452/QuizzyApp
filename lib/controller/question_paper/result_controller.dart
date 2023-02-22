import 'package:booking_app/controller/question_paper/queston_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../auth_controller.dart';

extension ResultController on QuestionController {
  int get correctQuestionCount => allQuestion
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsQuestions{
    return '$correctQuestionCount out of ${allQuestion.length} are correct';

  }

  String get points{
    var points = (correctQuestionCount / allQuestion.length)*100*
        (questionPaperModel.timeSeconds-remainSeconds)/questionPaperModel.timeSeconds*100;
    return points.toStringAsFixed(2);
  }
  Future<void> saveTextRs() async{
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null)
      return;
    batch.set(userRF.doc(_user.email).collection('myrecents_test').doc(
        questionPaperModel.id), {
      "points": points,
      "correct_answer": '$correctQuestionCount/${allQuestion.length}',
      "question_id": questionPaperModel.id,
      "time": questionPaperModel.timeSeconds - remainSeconds
    });
    batch.commit();
    navigateToHome();
  }

}
