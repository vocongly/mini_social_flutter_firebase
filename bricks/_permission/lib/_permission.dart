import 'package:_permission/src/storage.dart';

import 'src/camera.dart';
import 'src/gallery.dart';

class PermissionBrick {
  static CameraPermission camera() => CameraPermission();

  static GalleryPermission gallery() => GalleryPermission();

  static StoragePermission storage() => StoragePermission();
}
