import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart';

import 'failure.dart';
import 'service.dart';

abstract class RepositoryInterface {
  Future<Either<AppInfoPackageFailure, String>> getSupportedVersion();

  Future<Either<AppInfoPackageFailure, String>> getHotline();

  Future<Either<AppInfoPackageFailure, bool>> isRegistrationMode();

  Future<Either<AppInfoPackageFailure, String>> getAboutUsPageUrl();
}

class Repository implements RepositoryInterface {
  ServiceClient serviceClient = ServiceClient();

  @override
  Future<Either<AppInfoPackageFailure, String>> getSupportedVersion() async {
    try {
      String? supportedVersion;
      Response response = await serviceClient.get();
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      if (rawData['data'] != null) {
        rawData['data'].forEach((value) {
          if (value['key'] == "APP_VERSION") supportedVersion = value['value'];
        });
      }
      return Right(supportedVersion!);
    } catch (e) {
      if (e is ServerException) {
        return Left(AppInfoServerFailure());
      }
      return Left(AppInfoDataParsingFailure());
    }
  }

  @override
  Future<Either<AppInfoPackageFailure, String>> getHotline() async {
    try {
      String? hotline;
      Response response = await serviceClient.get();
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      if (rawData['data'] != null) {
        rawData['data'].forEach((value) {
          if (value['key'] == "APP_HOTLINE") hotline = value['value'];
        });
      }
      return Right(hotline!);
    } catch (e) {
      if (e is ServerException) {
        return Left(AppInfoServerFailure());
      }
      return Left(AppInfoDataParsingFailure());
    }
  }

  @override
  Future<Either<AppInfoPackageFailure, bool>> isRegistrationMode() async {
    try {
      bool? isRegistrationMode;
      Response response = await serviceClient.get();
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      if (rawData['data'] != null) {
        rawData['data'].forEach((value) {
          if (value['key'] == "SIGNUP_AVAILABLE") {
            isRegistrationMode = value['value'].toLowerCase() == 'true';
          }
        });
      }
      return Right(isRegistrationMode!);
    } catch (e) {
      if (e is ServerException) {
        return Left(AppInfoServerFailure());
      }
      return Left(AppInfoDataParsingFailure());
    }
  }

  @override
  Future<Either<AppInfoPackageFailure, String>> getAboutUsPageUrl() async {
    try {
      String? aboutUsPageUrl;
      Response response = await serviceClient.get();
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      if (rawData['data'] != null) {
        rawData['data'].forEach((value) {
          if (value['key'] == "HOSTNAME") aboutUsPageUrl = value['value'];
        });
      }
      return Right(aboutUsPageUrl!);
    } catch (e) {
      if (e is ServerException) {
        return Left(AppInfoServerFailure());
      }
      return Left(AppInfoDataParsingFailure());
    }
  }
}
