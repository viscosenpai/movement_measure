import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.label,
    required this.buttonPrimaryColor,
    required this.buttonTextColor,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Color? buttonPrimaryColor;
  final Color? buttonTextColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: buttonPrimaryColor,
      ),
      child: Container(
        width: deviceWidth * 0.4,
        height: 150.0,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: buttonTextColor,
          ),
        ),
      ),
    );
  }
}
