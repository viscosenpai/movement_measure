import 'package:flutter/material.dart';
import 'package:movement_measure/generated/l10n.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPages extends StatelessWidget {
  const IntroductionPages({
    Key? key,
    required this.onDone,
  }) : super(key: key);

  final void Function()? onDone;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    List<Map<String, dynamic>> tutorialContents = [
      {
        'imagePath': 'tutorial_1.png',
        'title': S.of(context).howToUseTitle1,
        'body': S.of(context).howToUseBody1,
      },
      {
        'imagePath': 'tutorial_2.png',
        'title': S.of(context).howToUseTitle2,
        'body': S.of(context).howToUseBody2,
      },
      {
        'imagePath': 'tutorial_3.png',
        'title': S.of(context).howToUseTitle3,
        'body': S.of(context).howToUseBody3,
      },
    ];

    return IntroductionScreen(
      controlsMargin: EdgeInsets.all(16.0),
      globalBackgroundColor: Colors.black,
      pages: tutorialPageViews(tutorialContents, deviceHeight),
      done: Text(
        S.of(context).done,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      onDone: onDone,
      showNextButton: false,
      dotsDecorator: DotsDecorator(
        size: Size.square(10.0),
        activeSize: Size(20.0, 10.0),
        activeColor: Colors.orange,
        color: Colors.grey,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

List<PageViewModel> tutorialPageViews(
    List<Map<String, dynamic>> tutorialContentList, double height) {
  return tutorialContentList.map((content) {
    return PageViewModel(
      image: Image(
        height: height * 0.3,
        image: AssetImage('images/${content["imagePath"]}'),
      ),
      titleWidget: Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Text(
          content['title'].toString(),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bodyWidget: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              content['body'].toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }).toList();
}
