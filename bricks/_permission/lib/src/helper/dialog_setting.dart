import 'dart:io';

import 'package:_permission/src/language/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showCameraDialogSetting(BuildContext context,
    [String? languageCode]) async {
  Language language = Language();
  final String systemLocales =
      WidgetsBinding.instance.window.locales.first.languageCode;
  language.setupData(languageCode ?? systemLocales);
  String title = language.key("requiresCameraTitle");
  String content = language.key("requiresCameraContent");
  String cancel = language.key("cancel");
  String settings = language.key("settings");
  if (Platform.isAndroid) {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      Text(cancel, style: const TextStyle(color: Colors.grey))),
              TextButton(
                  onPressed: () => openAppSettings(),
                  child: Text(settings,
                      style: const TextStyle(color: Colors.blue))),
            ],
          );
        });
  }
  if (Platform.isIOS && context.mounted) {
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  cancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => openAppSettings(),
                child:
                    Text(settings, style: const TextStyle(color: Colors.blue)),
              ),
            ],
          );
        });
  }
}

Future<void> showGalleryDialogSetting(BuildContext context,
    [String? languageCode]) async {
  Language language = Language();
  final String systemLocales =
      WidgetsBinding.instance.window.locales.first.languageCode;
  language.setupData(languageCode ?? systemLocales);
  String title = language.key("requiresGalleryTitle");
  String content = language.key("requiresGalleryContent");
  String cancel = language.key("cancel");
  String settings = language.key("settings");
  if (Platform.isAndroid) {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      Text(cancel, style: const TextStyle(color: Colors.grey))),
              TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: Text(settings,
                      style: const TextStyle(color: Colors.blue))),
            ],
          );
        });
  }
  if (Platform.isIOS && context.mounted) {
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  cancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                child:
                    Text(settings, style: const TextStyle(color: Colors.blue)),
              ),
            ],
          );
        });
  }
}

Future<bool?> showLimitedGalleryDialogSetting(BuildContext context,
    [String? languageCode]) async {
  bool? result;
  Language language = Language();
  final String systemLocales =
      WidgetsBinding.instance.window.locales.first.languageCode;
  language.setupData(languageCode ?? systemLocales);
  String title = language.key("requiresLimitedGalleryTitle");
  String content = language.key("requiresLimitedGalleryContent");
  String cancel = language.key("cancel");
  String settings = language.key("settings");
  await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                result = false;
                Navigator.pop(context);
              },
              child: Text(
                cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
                result = true;
              },
              child: Text(settings, style: const TextStyle(color: Colors.blue)),
            ),
          ],
        );
      });
  return result;
}

Future<void> showStorageDialogSetting(BuildContext context,
    [String? languageCode]) async {
  Language language = Language();
  final String systemLocales =
      WidgetsBinding.instance.window.locales.first.languageCode;
  language.setupData(languageCode ?? systemLocales);
  String title = language.key("requiresStorageTitle");
  String content = language.key("requiresStorageContent");
  String cancel = language.key("cancel");
  String settings = language.key("settings");
  if (Platform.isAndroid) {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      Text(cancel, style: const TextStyle(color: Colors.grey))),
              TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: Text(settings,
                      style: const TextStyle(color: Colors.blue))),
            ],
          );
        });
  }
  if (Platform.isIOS && context.mounted) {
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  cancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                child:
                    Text(settings, style: const TextStyle(color: Colors.blue)),
              ),
            ],
          );
        });
  }
}
