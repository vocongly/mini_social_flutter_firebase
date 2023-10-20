library _app_version;

import 'package:_app_version/src/app_version.dart';
import 'package:_app_version/src/helper.dart';
import 'package:package_info_plus/package_info_plus.dart';

export 'src/app_version.dart';

class AppVersionBrick {
  static Future<bool?> isSupportedVersion(AppVersion minimumVersion) {
    return checkSupportedVersion(minimumVersion);
  }

  static Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
