import 'package:booking_app/controller/question_paper/data_uploader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'firebase_ref/loading_status.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  DataUpLoader controller = Get.put(DataUpLoader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.complete
                ? "Upload completed"
                : "Uploading ...")),
      ),
    );
  }
}
