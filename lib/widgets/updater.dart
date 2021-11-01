import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movement_measure/services/version_check_service.dart';

class Updater extends StatefulWidget {
  const Updater({Key? key}) : super(key: key);

  @override
  _UpdaterState createState() => _UpdaterState();
}

class _UpdaterState extends State<Updater> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final versionCheckService =
          Provider.of<VersionCheckService>(context, listen: false);
      versionCheckService
          .versionCheck()
          .then((needUpdate) => _showUpdateDialog(needUpdate));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
    );
  }

  // FIXME ストアにアプリを登録したらurlが入れられる
  static const APP_STORE_URL =
      'https://apps.apple.com/jp/app/id[アプリのApple ID]?mt=8';

  // FIXME ストアにアプリを登録したらurlが入れられる
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=[アプリのパッケージ名]';

  /// 指定のURLを起動する. App Store or Play Storeのリンク
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // 更新版案内ダイアログを表示
  void _showUpdateDialog(bool needUpdate) {
    if (!needUpdate) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final title = "バージョン更新のお知らせ";
        final message = "新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい。";
        final btnLabel = "今すぐ更新";
        return new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                btnLabel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () =>
                  _launchURL(Platform.isIOS ? APP_STORE_URL : PLAY_STORE_URL),
            ),
          ],
        );
      },
    );
  }
}
