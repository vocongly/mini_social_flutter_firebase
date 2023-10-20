import 'dart:async';
import 'dart:io';

import 'package:_permission/_permission.dart';
import 'package:_photo/src/language/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as photo;
import 'package:image_picker/image_picker.dart';

abstract class PhotoBrickInterface {
  Future<photo.Image?> pick(BuildContext context);

  Future<photo.Image?> camera(BuildContext context);

  Future<photo.Image?> gallery(BuildContext context);
}

class PhotoBrick extends PhotoBrickInterface {
  @override
  Future<photo.Image?> pick(BuildContext context,
      [String? languageCode]) async {
    Language language = Language();
    final String systemLocales =
        WidgetsBinding.instance.window.locales.first.languageCode;
    language.setupData(languageCode ?? systemLocales);
    String takePhoto = language.key("takePhoto");
    String getGallery = language.key("getGallery");
    String cancel = language.key("cancel");
    Completer<photo.Image?> completer = Completer<photo.Image?>();
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                camera(context, null, languageCode)
                    .then((value) => completer.complete(value));
              },
              child: Text(takePhoto)),
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await gallery(context, null, languageCode)
                    .then((value) => completer.complete(value));
              },
              child: Text(getGallery)),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(cancel),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<photo.Image?> camera(BuildContext context,
      [Size? resizedSize, String? languageCode]) async {
    photo.Image? result;
    await PermissionBrick.camera()
        .forceRequest(context, languageCode)
        .then((value) async {
      if (!value) return;
      try {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          result = _resizeImageByPath(
              pickedFile.path, resizedSize ?? const Size(512, 512));
        }
      } catch (_) {
        debugPrint('FAILED TO PICK IMAGE');
      }
    });
    return result;
  }

  @override
  Future<photo.Image?> gallery(BuildContext context,
      [Size? resizedSize, String? languageCode]) async {
    photo.Image? result;
    if (Platform.isIOS) {
      await PermissionBrick.gallery()
          .forceRequest(context, languageCode)
          .then((value) async {
        if (!value) return;
        try {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            result = _resizeImageByPath(
                pickedFile.path, resizedSize ?? const Size(512, 512));
          }
        } catch (_) {
          debugPrint('FAILED TO PICK IMAGE');
        }
      });
    }
    if (Platform.isAndroid && context.mounted) {
      await PermissionBrick.storage()
          .forceRequest(context, languageCode)
          .then((value) async {
        if (!value) return;
        try {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            result = _resizeImageByPath(
                pickedFile.path, resizedSize ?? const Size(512, 512));
          }
        } catch (_) {
          debugPrint('FAILED TO PICK IMAGE');
        }
      });
    }
    return result;
  }
}

photo.Image _resizeImageByPath(String path, Size limitedSize) {
  photo.Image baseImage =
      photo.decodeImage(File(path).readAsBytesSync()) as photo.Image;
  double width = baseImage.width.toDouble();
  double height = baseImage.height.toDouble();
  if (width > limitedSize.width) {
    width = limitedSize.width;
    height = (baseImage.height / baseImage.width) * limitedSize.width;
  }
  if (height > limitedSize.height) {
    width = (baseImage.width / baseImage.height) * limitedSize.height;
    height = limitedSize.height;
  }
  photo.Image resizedImage =
      photo.copyResize(baseImage, width: width.round(), height: height.round());
  return resizedImage;
}
