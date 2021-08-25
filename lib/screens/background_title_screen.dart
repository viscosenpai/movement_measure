import 'package:flutter/material.dart';

class BackgroundTitleScreen extends StatelessWidget {
  const BackgroundTitleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: const SafeArea(
        child: Align(
          child: Text(
            'MOVEMENT MEASURE',
            style: TextStyle(
              height: 1.15,
              fontSize: 150,
              fontWeight: FontWeight.bold,
            ),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
