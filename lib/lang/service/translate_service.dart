import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TranslationService extends Translations {
  Future<TranslationService> init() async {
    String locale = Get.deviceLocale.toString();
    if (!locale.contains("en") && !locale.contains("vi")) {
      locale = "en_US";
    }
    await Get.updateLocale(Locale(locale));
    return this;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "welcome": "What do you want to learn today ?",
          "greet": "Hello,friend",
          "question": "Question",
          "question(s)": "question(s)",
          "next": "Next",
          "remaining": "Remaining",
          "complete": "Complete",
          "out of": "out of",
          "answered": "answered",
          "congratulation": "Congratulation",
          "youhave" : "You have",
          "point" : "point",
          "noti-complete":
              "Tap bellow question numbers to view correct answers",
          "go_home": "Go home",
          "try": "Try again",
          "logout": "Log out",
          "siGG":"Sign in with Google",
          "language":"Language",
          "slogan":
              "This is study app . You can use it as you want . If you understand how it works you would be able to scale it.",
          "slogan_2":
              "If you are not willing to learn, no one can help you. If you are determined to learn, no one can stop you"
        },
        'vi_VN': {
          "welcome": "Bạn muốn có thêm kiến thức gì hôm nay ?",
          "greet": "Xin chào",
          "question": "Câu",
          "language":"Ngôn ngữ",
          "question(s)": "câu hỏi",
          "next": "Tiếp",
          "remaining": "Còn lại",
          "complete": "Hoàn thành",
          "out of": "trên",
          "answered": "đã trả lời",
          "congratulation": "Chúc mừng",

  "siGG":"Đăng nhập bằng Google",
          "noti-complete":
              "Ấn vào câu hỏi bên dưới để xem kết quả đúng",
          "go_home": "Trang chủ",
          "try": "Thử lại",
          "youhave" : "Bạn có",
          "point" : "điểm",
          "logout": "Đăng xuất",
          "slogan_2":
              "Nếu bạn không sẵn sàng để học không ai có thể khuyên bạn , nếu bạn đã quyết định học không ai có thể cản bạn",
          "slogan":
              "Đây là ứng dụng học tập bạn có thể sử dụng nó bất cứ khi nào bạn muốn . Nó giúp bạn có thêm kiến thức và phát triển bản thân hơn"
        }
      };
}
