import 'package:booking_app/controller/auth_controller.dart';
import 'package:booking_app/firebase_ref/references.dart';
import 'package:booking_app/models/question_paper_model.dart';
import 'package:booking_app/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../screens/question/question_screen.dart';

class QuestionPaperController extends GetxController{
  final allPaperImages = <String>[].obs;
  final allPaper = <QuestionPaper>[].obs;
  @override
  void onReady() {
    getAllPaper();
    super.onReady();
  }

  Future<void> getAllPaper() async {
    List<String> imgName = [
      "biology",
      "chemistry",
      "maths",
      "physics"
    ];
    try{
      QuerySnapshot<Map<String,dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs.map((paper) => QuestionPaper.fromSnapshot(paper)).toList();
      allPaper.assignAll(paperList);
      for(var paper in paperList){
       final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.title);
       paper.imageUrl = imgUrl!;
      }
      allPaper.assignAll(paperList);
    }catch(e){
      print(e);
    }
  }
  void navigateToQuestion({required QuestionPaper paper, bool tryAgain=false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        Get.offNamed(QuestionScreen.routeName,arguments: paper,preventDuplicates: false);
      }else{
       Get.toNamed(QuestionScreen.routeName,arguments: paper);
      }
    }else{
      _authController.showLoginAlertDialogue();
    }

  }

}