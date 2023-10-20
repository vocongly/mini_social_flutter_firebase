import 'package:_authentication/src/data/repository/repository.dart';
import 'package:_authentication/src/error/failure.dart';
import 'package:_authentication/src/utils/helper/token_helper.dart';
import 'package:_authentication/src/utils/helper/validate_helper.dart';
import 'package:either_dart/either.dart';

export 'package:_authentication/src/error/failure.dart';

abstract class AuthenticationBrickInterface {
  Future<bool> authenticate();

  Future<Either<AuthenticationBrickFailure, void>> login(
      {required Map<String, dynamic> loginInfo});

  Future<Either<AuthenticationBrickFailure, void>> register(
      {required Map<String, dynamic> registerInfo});

  Future<Either<AuthenticationBrickFailure, void>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword});

  Future<String?> getAccessToken();

  void removeToken();
}

class AuthenticationBrick implements AuthenticationBrickInterface {
  @override
  Future<bool> authenticate() async {
    bool tokenValid = await TokenHelper.checkToken();
    return tokenValid;
  }

  @override
  Future<Either<AuthenticationBrickFailure, void>> login(
      {required Map<String, dynamic> loginInfo}) async {
    Either<AuthenticationBrickFailure, void> validUsername =
        ValidateHelper.email(loginInfo["email"]);
    if (validUsername.isLeft) return Left(validUsername.left);

    Either<AuthenticationBrickFailure, void> validPassword =
        ValidateHelper.password(loginInfo["password"]);
    if (validPassword.isLeft) return Left(validPassword.left);

    Either<AuthenticationBrickFailure, void> login =
        await Repository().login(loginInfo: loginInfo);
    if (login.isLeft) return Left(login.left);
    return const Right(null);
  }

  @override
  Future<String?> getAccessToken() async {
    bool tokenValid = await TokenHelper.checkToken();
    if (tokenValid) return TokenHelper.getAccessToken();
    return null;
  }

  @override
  void removeToken() {
    TokenHelper.removeToken();
  }

  @override
  Future<Either<AuthenticationBrickFailure, void>> register(
      {required Map<String, dynamic> registerInfo}) async {
    Either<AuthenticationBrickFailure, void> validUsername =
        ValidateHelper.email(registerInfo["email"]);
    if (validUsername.isLeft) return Left(validUsername.left);

    Either<AuthenticationBrickFailure, void> validPassword =
        ValidateHelper.password(registerInfo["password"]);
    if (validPassword.isLeft) return Left(validPassword.left);

    Either<AuthenticationBrickFailure, void> validConfirmPassword =
        ValidateHelper.confirmPassword(registerInfo["confirmPassword"]);
    if (validConfirmPassword.isLeft) return Left(validConfirmPassword.left);

    if (registerInfo["password"] != registerInfo["confirmPassword"]) {
      return Left(BNotMatchPasswordFailure());
    }

    Either<AuthenticationBrickFailure, void> register =
        await Repository().register(registerInfo: registerInfo);
    if (register.isLeft) return Left(register.left);

    return const Right(null);
  }

  @override
  Future<Either<AuthenticationBrickFailure, void>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    Either<AuthenticationBrickFailure, void> validOldPassword =
        ValidateHelper.password(oldPassword);
    if (validOldPassword.isLeft) return Left(validOldPassword.left);

    Either<AuthenticationBrickFailure, void> validNewPassword =
        ValidateHelper.newPassword(newPassword);
    if (validNewPassword.isLeft) return Left(validNewPassword.left);

    Either<AuthenticationBrickFailure, void> validConfirmNewPassword =
        ValidateHelper.confirmPassword(confirmNewPassword);
    if (validConfirmNewPassword.isLeft) {
      return Left(validConfirmNewPassword.left);
    }
    if (newPassword != confirmNewPassword) {
      return Left(BNotMatchPasswordFailure());
    }
    if (newPassword == oldPassword) {
      return Left(BMatchPasswordFailure());
    }

    var passwordInfo = {"oldPassword": oldPassword, "newPassword": newPassword};
    Either<AuthenticationBrickFailure, void> changePassword =
        await Repository().changePassword(passwordInfo: passwordInfo);
    if (changePassword.isLeft) return Left(changePassword.left);

    return const Right(null);
  }
}
