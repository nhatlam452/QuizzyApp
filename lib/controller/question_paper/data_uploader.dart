import 'dart:convert';
import 'package:booking_app/firebase_ref/loading_status.dart';
import 'package:booking_app/firebase_ref/references.dart';
import 'package:booking_app/models/question_paper_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataUpLoader extends GetxController{
  @override
  void onReady(){
    uploadData();
    super.onReady();
  }
  final loadingStatus =LoadingStatus.loading.obs; //loading status is obs
  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;//0
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
    final Map<String,dynamic> manifestMap = json.decode(manifestContent);
    /*
    * load json file - print path
    * */
    final papersInAssets = manifestMap.keys.where((path) => path.startsWith("assets/DB/papers")&&path.contains(".json"))
        .toList();
    List<QuestionPaper> questionPaper =  [];
    for(var paper in papersInAssets){
      String stringPaperContent = await rootBundle.loadString(paper);
      print(stringPaperContent);
      questionPaper.add(QuestionPaper.fromJson(json.decode(stringPaperContent)));
    }


    var batch = fireStore.batch();
    for(var paper in questionPaper){
      batch.set(questionPaperRF.doc(paper.id), {
        "title":paper.title,
        "image_url":paper.imageUrl,
        "description":paper.description,
        "time_seconds":paper.timeSeconds,
        "question_count" : paper.questions==null?0:paper.questions!.length,
      });
      for(var questions in paper.questions!){
       final questionPath = questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          "question" : questions.question,
          "correct_answer" : questions.correctAnswer,
        });
        for(var answer in questions.answers){
          batch.set(questionPath.collection("answers").doc(answer.identifier), {
            "identifier" : answer.identifier,
            "answer" : answer.answer
          });
        }
      }

    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.complete;
  }
}


