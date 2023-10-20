import 'package:_app_version/src/app_version.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<bool?> checkSupportedVersion(AppVersion minimumVersion) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppVersion? currentVersion = AppVersion.toModule(packageInfo.version);
  if (currentVersion == null) return null;
  if (currentVersion.major > minimumVersion.major) return true;
  if (currentVersion.major < minimumVersion.major) return false;
  if (currentVersion.minor > minimumVersion.minor) return true;
  if (currentVersion.minor < minimumVersion.minor) return false;
  if (currentVersion.patch < minimumVersion.patch) return false;
  return true;
}
