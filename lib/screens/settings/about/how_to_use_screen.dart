import 'package:flutter/material.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:movement_measure/utilities/constants.dart';
import 'package:movement_measure/screens/settings/about/about_screen.dart';
import 'package:movement_measure/widgets/introduction_pages.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: kDefaultBlur,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                kPpageRouteBuilder(AboutScreen()),
              );
            },
            iconSize: 30.0,
            icon: Icon(Icons.navigate_before),
          ),
          title: Text(S.of(context).howToUse),
        ),
        body: IntroductionPages(
          onDone: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              kPpageRouteBuilder(AboutScreen()),
            );
          },
        ),
      ),
    );
  }
}
