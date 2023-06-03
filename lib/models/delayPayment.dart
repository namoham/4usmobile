class DelayPayment {

  int _idBeneficiary;
  int _idClass;
  int _synch;
  String _nameBeneficiary;
  String _nameClass;
  String _codeColor;
  String _beneficiaryAddress;
  String _telephone;
  String _identity;
  String _photo;
  String _isSend;

  DelayPayment(this._nameBeneficiary, this._nameClass,this._codeColor, this._beneficiaryAddress, this._telephone, this._identity, this._photo, this._isSend);

  DelayPayment.withId(
      this._idBeneficiary,
      this._idClass,
      this._synch,
      this._nameBeneficiary,
      this._nameClass,
      this._codeColor,
      this._beneficiaryAddress,
      this._telephone,
      this._identity,
      this._photo,
      this._isSend);

  int get idBeneficiary => _idBeneficiary;

  int get idClass => _idClass;

  int get synch => _synch;

  // ignore: non_constant_identifier_names
  String get Name => _nameBeneficiary;

  String get nameClass => _nameClass;

  String get colorCode => _codeColor;

  String get mapsAddress => _beneficiaryAddress;

  String get telephone => _telephone;

  // ignore: non_constant_identifier_names
  String get identity_ => _identity;

  String get photo => _photo;

  String get isSend => _isSend;


  set synch(int newsynch) {
    this._synch = newsynch;
  }

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    this._nameBeneficiary = newName;
  }

  set nameClass(String newNameClass) {
    this._nameClass = newNameClass;
  }
  set colorCode(String newColor) {
    this._codeColor = newColor;
  }
  set mapsAddress(String newMapsAddress) {
    this._beneficiaryAddress = newMapsAddress;
  }
  set telephone(String newTelephone) {
    this._telephone = newTelephone;
  }
  // ignore: non_constant_identifier_names
  set identity_(String newIdentity) {
    this._identity = newIdentity;
  }
  set photo(String newphoto) {
    this._photo = newphoto;
  }
  set isSend(String newisSend) {
    this._isSend = newisSend;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (idBeneficiary != null) {
      map['idBeneficiary'] = _idBeneficiary;
    }
    map['idClass'] = _idClass;
    map['synch'] = _synch;
    map['Name'] = _nameBeneficiary;
    map['nameClass'] = _nameClass;
    map['colorCode'] = _codeColor;
    map['mapsAddress'] = _beneficiaryAddress;
    map['telephone'] = _telephone;
    map['identity_'] = _identity;
    map['photo'] = _photo;
    map['isSend'] = _isSend;

    return map;
  }

  DelayPayment.fromMapObject(Map<String, dynamic> map) {
    this._idBeneficiary = map['idBeneficiary'];
    this._idClass = map['idClass'];
    this._synch = map['synch'];
    this._nameBeneficiary = map['Name'];
    this._nameClass = map['nameClass'];
    this._codeColor = map['colorCode'];
    this._beneficiaryAddress = map['mapsAddress'];
    this._telephone = map['telephone'];
    this._identity = map['identity_'];
    this._photo = map['photo'];
    this._isSend = map['isSend'];
  }
}