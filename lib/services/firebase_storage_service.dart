import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      if (imgName.trim() == 'Vật lý'.trim()) imgName = 'physics';
      if (imgName.trim() == 'Hóa học'.trim()) imgName = 'chemistry';
      if (imgName.trim() == 'Toán học'.trim()) imgName = 'maths';
      if (imgName.trim() == 'Sinh học'.trim()) imgName = 'biology';
      print(imgName);
      var uriRef = firebaseStorage
          .child("question_paper_images")
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await uriRef.getDownloadURL();
      print(imgUrl);
      return imgUrl;
    } catch (e) {
      return null;
    }
  }
}
