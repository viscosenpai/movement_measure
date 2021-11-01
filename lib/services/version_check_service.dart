import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

class VersionCheckService with ChangeNotifier {
  static const String DEV_VERSION_CONFIG = "dev_app_version";
  static const String CONFIG_VERSION = "force_update_app_version";

  /// バージョンチェック関数
  Future<bool> versionCheck() async {
    // versionCode(buildNumber)取得
    final PackageInfo info = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(info.buildNumber);
    // releaseビルドかどうかで取得するconfig名を変更
    final configName = bool.fromEnvironment('dart.vm.product')
        ? CONFIG_VERSION
        : DEV_VERSION_CONFIG;

    // remote config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // 常にサーバーから取得するようにするため期限を最小限にセット
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 0),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetchAndActivate();
      int newVersion = remoteConfig.getInt(configName);
      if (newVersion > currentVersion) {
        return true;
      }
    } on PlatformException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    return false;
  }
}
