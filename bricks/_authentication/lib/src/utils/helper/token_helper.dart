import 'package:_authentication/src/data/config/locator/secure_storage_key.dart';
import 'package:_authentication/src/data/config/service/local_service_client.dart';
import 'package:_authentication/src/data/model/token.dart';
import 'package:_authentication/src/data/repository/repository.dart';
import 'package:_authentication/src/error/failure.dart';
import 'package:either_dart/either.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  static Future<bool> checkToken() async {
    String? accessToken =
        await LocalServiceClient.get(SecureStorageKey.accessToken);
    String? refreshToken =
        await LocalServiceClient.get(SecureStorageKey.refreshToken);
    if (accessToken != null && !isInDate(accessToken)) {
      return true;
    }
    if (refreshToken != null && !isInDate(refreshToken)) {
      Either<AuthenticationBrickFailure, void> refreshRepository =
          await Repository().refreshToken(refreshToken: refreshToken);
      if (refreshRepository.isRight) {
        return await TokenHelper.checkToken();
      }
    }
    return false;
  }

  static Future<String?> getAccessToken() async {
    return await LocalServiceClient.get(SecureStorageKey.accessToken);
  }

  static Future<void> saveToken({required Token token}) async {
    await LocalServiceClient.save(SecureStorageKey.accessToken, token.token);
    await LocalServiceClient.save(
        SecureStorageKey.refreshToken, token.refreshToken);
  }

  static Future<void> removeToken() async {
    await LocalServiceClient.delete(SecureStorageKey.accessToken);
    await LocalServiceClient.delete(SecureStorageKey.refreshToken);
  }

  static bool isInDate(String token) {
    return JwtDecoder.isExpired(token);
  }
}
