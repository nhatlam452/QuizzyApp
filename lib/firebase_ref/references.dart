import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

final fireStore = FirebaseFirestore.instance;
//use switch case
final questionPaperRF = fireStore.collection(Get.locale?.languageCode=='vi'?'questionPapers-vn':'questionPapers');
Reference get firebaseStorage => FirebaseStorage.instance.ref();

final userRF = fireStore.collection("users");

DocumentReference questionRF({
  required String paperId,
  required String questionId,
}) =>
    questionPaperRF.doc(paperId).collection("questions").doc(questionId);

