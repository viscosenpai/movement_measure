import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPages extends StatelessWidget {
  const IntroductionPages({
    Key? key,
    required this.onDone,
  }) : super(key: key);

  final void Function()? onDone;

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      controlsMargin: EdgeInsets.all(16.0),
      globalBackgroundColor: Color(0x99000000),
      pages: tutorialPageViews(tutorialContents),
      done: const Text("Done",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          )),
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

List<Map<String, dynamic>> tutorialContents = [
  {
    'imagePath': 'tutorial_1.png',
    'title': 'あなたの道のりを記録しよう',
    'body': '時間と移動した距離を計るだけのシンプルなライフログアプリです',
  },
  {
    'imagePath': 'tutorial_2.png',
    'title': '思い出を残そう',
    'body': '移動中に起こったイベントをコメントで記録できます',
  },
  {
    'imagePath': 'tutorial_3.png',
    'title': '毎日の道のりを振り返ろう',
    'body': '日記のように日々の道のりの振り返りができます',
  },
];

List<PageViewModel> tutorialPageViews(
    List<Map<String, dynamic>> tutorialContentList) {
  return tutorialContentList.map((content) {
    return PageViewModel(
      image: Image(
        image: AssetImage('images/${content["imagePath"]}'),
      ),
      titleWidget: Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Text(
          content['title'].toString(),
          style: TextStyle(
            fontSize: 24.0,
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
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }).toList();
}
