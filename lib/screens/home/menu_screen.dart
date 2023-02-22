import "package:booking_app/configs/themes/app_colors.dart";
import "package:booking_app/configs/themes/ui_parameters.dart";
import "package:booking_app/controller/zoom_drawer_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    disabledForegroundColor: onSurfaceTextColor))),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      controller.toggleDrawer();
                    },
                  )),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3),
                child: Column(
                  children: [
                    Obx(() => controller.user.value == null
                        ? const SizedBox()
                        : Text(
                            controller.user.value!.displayName ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: onSurfaceTextColor),
                          )),
                    const Spacer(flex: 1,),
                    _DrawerButton(icon: Icons.web, label: "website",onPressed: ()=>controller.website(),),
                    _DrawerButton(icon: Icons.facebook, label: "facebook",onPressed: ()=>controller.website(),),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: _DrawerButton(icon: Icons.email, label: "email",onPressed: ()=>controller.email(),),
                    ),
                    const Spacer(flex: 4,),

                    _DrawerButton(icon: Icons.logout, label: "logout",onPressed: ()=>controller.signOut(),),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({Key? key, required this.icon, required this.label, this.onPressed}) : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 15,
        color: onSurfaceTextColor,
      ),
      label: Text(label,style: TextStyle(
    color: onSurfaceTextColor
    )),
    );
  }
}
