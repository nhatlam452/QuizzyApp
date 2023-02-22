
import 'package:booking_app/configs/themes/app_light_theme.dart';
import 'package:booking_app/controller/theme_controller.dart';
import 'package:booking_app/data_uploadder_screen.dart';
import 'package:booking_app/firebase_options.dart';
import 'package:booking_app/routes/app_routes.dart';
import 'package:booking_app/screens/introduction/introduction.dart';
import 'package:booking_app/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/initial_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}


// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(GetMaterialApp(
//      home: DataUploaderScreen(),
//   ));
// }
