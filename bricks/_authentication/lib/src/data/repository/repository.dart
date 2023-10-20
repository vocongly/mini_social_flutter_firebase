import 'package:_authentication/_authentication.dart';
import 'package:_authentication/src/data/config/locator/service_path.dart';
import 'package:_authentication/src/data/config/service/api_service_client.dart';
import 'package:_authentication/src/data/model/token.dart';
import 'package:_authentication/src/error/exception.dart';
import 'package:_authentication/src/utils/helper/error_helper.dart';
import 'package:_authentication/src/utils/helper/token_helper.dart';
import 'package:either_dart/either.dart';

abstract class RepositoryInterface {
  Future<Either<AuthenticationBrickFailure, void>> login(
      {required Map<String, dynamic> loginInfo});

  Future<Either<AuthenticationBrickFailure, void>> register(
      {required Map<String, dynamic> registerInfo});

  Future<Either<AuthenticationBrickFailure, void>> changePassword(
      {required Map<String, dynamic> passwordInfo});

  Future<Either<AuthenticationBrickFailure, void>> refreshToken(
      {required String refreshToken});
}

class Repository implements RepositoryInterface {
  @override
  Future<Either<AuthenticationBrickFailure, void>> login(
      {required Map<String, dynamic> loginInfo}) async {
    try {
      Map<String, dynamic> response = await APIServiceClient.post(
        uri: ServicePath.login,
        params: loginInfo,
        withToken: false,
      );
      Token token = Token.fromJson(response);
      await TokenHelper.saveToken(token: token);

      /// Check role (Accept Customer role only)
      bool isCustomer = await _isCustomerRole();
      if (isCustomer) {
        return const Right(null);
      } else {
        AuthenticationBrick().removeToken();
        throw AuthorizationException();
      }
    } catch (e) {
      AuthenticationBrickFailure failure =
          ErrorHelper.commonExceptionToFeature(e);
      return Left(failure);
    }
  }

  @override
  Future<Either<AuthenticationBrickFailure, void>> refreshToken(
      {required String refreshToken}) async {
    try {
      Map<String, dynamic> response = await APIServiceClient.post(
        uri: ServicePath.refreshToken,
        params: {"refreshToken": refreshToken},
        withToken: false,
      );
      Token token = Token.fromJson(response);
      await TokenHelper.saveToken(token: token);
      return const Right(null);
    } catch (e) {
      AuthenticationBrickFailure failure =
          ErrorHelper.commonExceptionToFeature(e);
      return Left(failure);
    }
  }

  @override
  Future<Either<AuthenticationBrickFailure, void>> register(
      {required Map<String, dynamic> registerInfo}) async {
    try {
      await APIServiceClient.post(
        uri: ServicePath.register,
        params: registerInfo,
        withToken: false,
      );
      return const Right(null);
    } catch (e) {
      AuthenticationBrickFailure failure =
          ErrorHelper.commonExceptionToFeature(e);
      return Left(failure);
    }
  }

  Future<bool> _isCustomerRole() async {
    try {
      final response = await APIServiceClient.get(uri: ServicePath.user);
      final role = response['role'];
      return role == "CUSTOMER";
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<AuthenticationBrickFailure, void>> changePassword(
      {required Map<String, dynamic> passwordInfo}) async {
    try {
      await APIServiceClient.post(
        uri: ServicePath.changePassword,
        params: passwordInfo,
      );
      return const Right(null);
    } catch (e) {
      AuthenticationBrickFailure failure =
          ErrorHelper.commonExceptionToFeature(e);
      return Left(failure);
    }
  }
}
