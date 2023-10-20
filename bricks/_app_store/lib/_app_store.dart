import 'dart:io';

import 'package:_app_store/src/constant.dart';
import 'package:either_dart/either.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStoreBrick {
  static Future<Either<Exception, void>> gotoStore() async {
    if (Platform.isIOS) {
      var url = 'https://apps.apple.com/app/$appId';
      var uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        return Left(Exception());
      }
    }
    if (Platform.isAndroid) {
      var url = 'https://play.google.com/store/apps/details?id=$appPackageName';
      var uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        return Left(Exception());
      }
    }
    return Left(Exception());
  }
}
