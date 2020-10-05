class Usuario {
  String _sId;
  String _nome;
  String _email;
  String _datanasc;
  String _senha;

  Usuario(this._sId, this._nome, this._email, this._datanasc, this._senha);

  String get sId => _sId;

  set sId(String value) {
    _sId = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get datanasc => _datanasc;

  set datanasc(String value) {
    _datanasc = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }
}
