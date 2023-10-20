import 'package:_authentication/src/error/failure.dart';
import 'package:either_dart/either.dart';

class ValidateHelper {
  static Either<AuthenticationBrickFailure, void> email(String username) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp validEmail = RegExp(pattern);
    if (username.isEmpty) {
      return Left(BEmptyUsernameFailure());
    }
    if (!validEmail.hasMatch(username)) {
      return Left(BInvalidUsernameFailure());
    }
    return const Right(null);
  }

  static Either<AuthenticationBrickFailure, void> password(String password) {
    String moreThan8CharPattern = r"^.{8,}$";
    String noSpacePattern = r"^(?!.* )";
    RegExp moreThan8Char = RegExp(moreThan8CharPattern);
    RegExp noSpace = RegExp(noSpacePattern);
    if (password.isEmpty) {
      return Left(BEmptyPasswordFailure());
    }
    if (!noSpace.hasMatch(password)) {
      return Left(BSpacingPasswordFailure());
    }
    if (!moreThan8Char.hasMatch(password)) {
      return Left(BLessThan8CharsPasswordFailure());
    }
    return const Right(null);
  }

  static Either<AuthenticationBrickFailure, void> newPassword(String password) {
    String moreThan8CharPattern = r"^.{8,}$";
    String noSpacePattern = r"^(?!.* )";
    RegExp moreThan8Char = RegExp(moreThan8CharPattern);
    RegExp noSpace = RegExp(noSpacePattern);
    if (password.isEmpty) {
      return Left(BEmptyNewPasswordFailure());
    }
    if (!noSpace.hasMatch(password)) {
      return Left(BSpacingNewPasswordFailure());
    }
    if (!moreThan8Char.hasMatch(password)) {
      return Left(BLessThan8CharsNewPasswordFailure());
    }
    return const Right(null);
  }

  static Either<AuthenticationBrickFailure, void> confirmPassword(
      String password) {
    String moreThan8CharPattern = r"^.{8,}$";
    String noSpacePattern = r"^(?!.* )";
    RegExp moreThan8Char = RegExp(moreThan8CharPattern);
    RegExp noSpace = RegExp(noSpacePattern);
    if (password.isEmpty) {
      return Left(BEmptyConfirmPasswordFailure());
    }
    if (!noSpace.hasMatch(password)) {
      return Left(BSpacingConfirmPasswordFailure());
    }
    if (!moreThan8Char.hasMatch(password)) {
      return Left(BLessThan8CharsConfirmPasswordFailure());
    }
    return const Right(null);
  }
}
