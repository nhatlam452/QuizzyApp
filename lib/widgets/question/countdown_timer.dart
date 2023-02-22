import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final Color? color;
  final String time;

  const CountdownTimer({Key? key, this.color, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timer, color: color ?? Theme
            .of(context)
            .primaryColor,),
        const SizedBox(width: 5,),
        Text(time, style: TextStyle(
            color: UIParameters.isDarkMode() ? Theme
                .of(context)
                .textTheme
                .bodyLarge!
                .color : Theme.of(context).primaryColor,
            letterSpacing: 2
        ).copyWith(color: color),)
      ],
    );
  }
}
