import 'package:_permission/src/helper/dialog_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryPermission {
  Future<PermissionStatus> getStatus() async {
    return await Permission.photos.status;
  }

  Future<PermissionStatus> request() async {
    final status = await Permission.photos.request();
    return status;
  }

  Future<bool> forceRequest(BuildContext context,
      [String? languageCode]) async {
    await Permission.photos.request();
    final status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isLimited && context.mounted) {
      bool? limitedResult =
          await showLimitedGalleryDialogSetting(context, languageCode);
      if (limitedResult != null && !limitedResult) return true;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      if (context.mounted) {
        await showGalleryDialogSetting(context, languageCode);
      }
    }
    return false;
  }
}
