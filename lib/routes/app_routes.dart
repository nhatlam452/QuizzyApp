import 'package:booking_app/controller/question_paper/question_paper_controller.dart';
import 'package:booking_app/controller/question_paper/queston_controller.dart';
import 'package:booking_app/controller/zoom_drawer_controller.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/screens/home/menu_screen.dart';
import 'package:booking_app/screens/introduction/introduction.dart';
import 'package:booking_app/screens/login/login_screen.dart';
import 'package:booking_app/screens/question/answer_check.dart';
import 'package:booking_app/screens/question/question_screen.dart';
import 'package:booking_app/screens/question/result_screen.dart';
import 'package:booking_app/screens/question/test_overview_screen.dart';
import 'package:booking_app/screens/splash/splash_screen.dart';
import 'package:booking_app/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/introduction", page: () => AppIntroduction()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: ResultScreen.routeNamed, page: () => ResultScreen()),
        GetPage(name: AnswerCheckScreen.routedNamed, page: () => AnswerCheckScreen()),
        GetPage(name: TestOverViewScreen.routeNamed, page: () => TestOverViewScreen()),
        GetPage(
            name: QuestionScreen.routeName,
            page: () => QuestionScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionController>(QuestionController());
            })),
        GetPage(
            name: "/home",
            page: () => HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
      ];
}
