import 'package:flutter/material.dart';

class BackgroundTitleScreen extends StatelessWidget {
  const BackgroundTitleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: Align(
          child: null,
        ),
      ),
    );
  }
}
