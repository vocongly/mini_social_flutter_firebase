class Token {
  Token(this._token, this._refreshToken);

  static Token fromJson(dynamic json) {
    return Token(json['token'], json['refreshToken']);
  }

  final String _token;
  final String _refreshToken;

  String get token => _token;

  String get refreshToken => _refreshToken;
}
