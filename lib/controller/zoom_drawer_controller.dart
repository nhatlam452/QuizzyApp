import 'package:booking_app/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void website() {
    _launch("https://github.com/nhatlam452");
  }

  void facebook() {
    _launch("https://www.facebook.com/");
  }

  void email() {
    final Uri emailLauncher =
        Uri(scheme: 'mailto', path: 'nhatlam452@gmail.com');
    _launch(emailLauncher.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'could not lauch $url';
    }
  }
}
