import 'package:_permission/src/helper/dialog_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermission {
  Future<PermissionStatus> getStatus() async {
    return await Permission.storage.status;
  }

  Future<PermissionStatus> request() async {
    final status = await Permission.storage.request();
    return status;
  }

  Future<bool> forceRequest(BuildContext context,
      [String? languageCode]) async {
    await Permission.storage.request();
    final status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isPermanentlyDenied || status.isLimited) {
      if (context.mounted) {
        await showStorageDialogSetting(context, languageCode);
      }
    }
    return false;
  }
}
