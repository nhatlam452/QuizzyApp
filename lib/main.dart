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
import 'lang/service/translate_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServices();
  InitialBindings().dependencies();
  runApp(MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(
      () => TranslationService().init()); // initialize TranslationService
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Locale>(
      future: Get.find<ThemeController>().getSavedLocale(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetMaterialApp(
            translations: TranslationService(),
            locale: snapshot.data,
            fallbackLocale: Locale("en","US"),
            debugShowCheckedModeBanner: false,
            theme: Get.find<ThemeController>().lightTheme,
            darkTheme: Get.find<ThemeController>().darkTheme,
            getPages: AppRoutes.routes(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
