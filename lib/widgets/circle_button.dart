import 'package:flutter/material.dart';
import 'package:movement_measure/enum/activity_state.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.activityState,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final ActivityState activityState;
  final String label;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: activityState.activityColor,
      ),
      child: Container(
        width: 150.0,
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
            color: activityState.circleButtonTextColor,
          ),
        ),
      ),
    );
  }
}
