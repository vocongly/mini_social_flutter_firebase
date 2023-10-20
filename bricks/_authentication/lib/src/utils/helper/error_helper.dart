import 'package:_authentication/src/error/exception.dart';
import 'package:_authentication/src/error/failure.dart';

class ErrorHelper {
  static void handleExceptionByStatusCode(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 400 || statusCode == 401) throw AuthorizationException();
    throw Exception();
  }

  static AuthenticationBrickFailure commonExceptionToFeature(Object exception) {
    if (exception is ServerException) return BServerFailure();
    if (exception is AuthorizationException) {
      return BAuthorizationFailure();
    }
    return BDataParsingFailure();
  }
}
