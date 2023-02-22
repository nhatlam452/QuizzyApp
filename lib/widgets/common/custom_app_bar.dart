import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:booking_app/screens/question/test_overview_screen.dart';
import 'package:booking_app/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/themes/app_icon.dart';
import '../../configs/themes/custom_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);

  CustomAppBar(
      {Key? key,
      this.title = "",
      this.titleWidget,
      this.showActionIcons = false,
      this.onMenuActionTap,
      this.leading})
      : super(key: key);
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcons;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
      child: Stack(
        children: [
          Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarTS,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showActionIcons)
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: AppCircleButton(
                    child: const Icon(AppIcons.menu),
                    onTap: onMenuActionTap ?? ()=>Get.toNamed(TestOverViewScreen.routeNamed),
                  ),
                ),
            ],
          )
        ],
      ),
    ));
  }
}
