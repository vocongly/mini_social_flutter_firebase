import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'helper/dialog_setting.dart';

class CameraPermission {
  Future<PermissionStatus> getStatus() async {
    return await Permission.camera.status;
  }

  Future<PermissionStatus> request() async {
    final status = await Permission.camera.request();
    return status;
  }

  Future<bool> forceRequest(BuildContext context,
      [String? languageCode]) async {
    await Permission.camera.request();
    final status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isPermanentlyDenied) {
      if (context.mounted) await showCameraDialogSetting(context, languageCode);
    }
    return false;
  }
}
