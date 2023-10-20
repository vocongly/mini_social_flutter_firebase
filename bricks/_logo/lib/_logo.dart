import 'package:_logo/utils/src/animated_logo.dart';
import 'package:_logo/utils/src/still_logo.dart';
import 'package:_logo/utils/src/utils/image_path.dart';

class LogoBrick {
  static tmaAnimated({required double width}) => AnimatedLogo(width: width);

  static tma({required double width}) =>
      StillLogo(logoImage: ImagePath.fullPointLogo, width: width);
}
