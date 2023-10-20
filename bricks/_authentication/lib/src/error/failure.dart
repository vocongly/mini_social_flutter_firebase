abstract class AuthenticationBrickFailure {}

/// Common
class BServerFailure extends AuthenticationBrickFailure {}

class BAuthorizationFailure extends AuthenticationBrickFailure {}

class BDataParsingFailure extends AuthenticationBrickFailure {}

/// Login
class BEmptyUsernameFailure extends AuthenticationBrickFailure {}

class BEmptyPasswordFailure extends AuthenticationBrickFailure {}

class BInvalidUsernameFailure extends AuthenticationBrickFailure {}

class BSpacingPasswordFailure extends AuthenticationBrickFailure {}

class BLessThan8CharsPasswordFailure extends AuthenticationBrickFailure {}

/// Register

class BEmptyNewPasswordFailure extends AuthenticationBrickFailure {}

class BSpacingNewPasswordFailure extends AuthenticationBrickFailure {}

class BLessThan8CharsNewPasswordFailure extends AuthenticationBrickFailure {}

class BEmptyConfirmPasswordFailure extends AuthenticationBrickFailure {}

class BSpacingConfirmPasswordFailure extends AuthenticationBrickFailure {}

class BLessThan8CharsConfirmPasswordFailure
    extends AuthenticationBrickFailure {}

class BNotMatchPasswordFailure extends AuthenticationBrickFailure {}

class BMatchPasswordFailure extends AuthenticationBrickFailure {}
