import 'package:booking_app/controller/auth_controller.dart';
import 'package:booking_app/controller/theme_controller.dart';
import 'package:get/get.dart';

import '../services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.put(FirebaseStorageService());

  }
}
