import 'package:_app_info/src/failure.dart';
import 'package:_app_info/src/repository.dart';
import 'package:either_dart/either.dart';

export 'package:_app_info/src/failure.dart';

class AppInfoBrick {
  final Repository _repository = Repository();

  Future<Either<AppInfoPackageFailure, String>> getSupportedVersion() async {
    Either<AppInfoPackageFailure, String> supportedVersion =
        await _repository.getSupportedVersion();
    if (supportedVersion.isLeft) return Left(supportedVersion.left);
    return Right(supportedVersion.right);
  }

  Future<Either<AppInfoPackageFailure, String>> getHotline() async {
    Either<AppInfoPackageFailure, String> hotline =
        await _repository.getHotline();
    if (hotline.isLeft) return Left(hotline.left);
    return Right(hotline.right);
  }

  Future<Either<AppInfoPackageFailure, String>> getAboutUsPageUrl() async {
    Either<AppInfoPackageFailure, String> aboutUsPageUrl =
        await _repository.getAboutUsPageUrl();
    if (aboutUsPageUrl.isLeft) return Left(aboutUsPageUrl.left);
    return Right(aboutUsPageUrl.right);
  }

  Future<bool> isRegistrationMode() async {
    Either<AppInfoPackageFailure, bool> registrationMode =
        await _repository.isRegistrationMode();
    if (registrationMode.isRight) if (registrationMode.right) return true;
    return false;
  }
}
