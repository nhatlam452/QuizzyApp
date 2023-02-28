import 'package:booking_app/configs/themes/custom_text_style.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:booking_app/controller/question_paper/question_paper_controller.dart';
import 'package:booking_app/models/question_paper_model.dart';
import 'package:booking_app/widgets/app_icon_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_icon.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  final QuestionPaper model;

  const QuestionCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: InkWell(
        onTap: (){
          controller.navigateToQuestion(paper: model,tryAgain: false);

        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (content, url, error) =>
                              Image.asset("assets/images/app_splash_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cartTitles(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        Row(
                          children: [
                            AppIconText(
                                icon: Icon(
                                  Icons.help_outline_sharp,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                                text: Text(
                                  '${model.questionCount}'+ 'question(s)'.tr,
                                  style: detailText.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            AppIconText(
                                icon: Icon(
                                  Icons.timer,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                                text: Text(
                                  '${model.timeInMinits()}',
                                  style: detailText.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: -_padding,
                  right: -_padding,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: Icon(AppIcons.trophyOutline),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardBorderRadius),
                              bottomRight: Radius.circular(cardBorderRadius)),
                          color: Theme.of(context).primaryColor),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
