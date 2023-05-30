// import 'package:cashpoint/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {this.text,
      this.onPressed,
      this.color,
      this.radius,
      this.width,
      this.height,
      this.textColor,
      this.font,
      this.isLoading});

  final String? text;
  final Function()? onPressed;
  final Color? color;
  final double? radius;
  final double? width;
  final double? height;
  final Color? textColor;
  final double? font;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width!,
      height: height!,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!),
            )),
        onPressed: (() => onPressed!()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading!
              ? Image.asset("assets/images/loader.gif",
                  color: Colors.white, height: 35.0, width: 35.0)
              : Text(
                  text!,
                  style: TextStyle(
                      fontSize: font,
                      color: textColor,
                      fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
