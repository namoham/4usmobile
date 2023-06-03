class DeList {

  // ignore: non_constant_identifier_names
  int _IdBeneficiary;
  // ignore: non_constant_identifier_names
  int _IdDemand;
  int _natureDemand;
  int _sector;
  int _natureProject;
  int _synch;
  String _designation;
  String _userName;
  String _isSend;

  DeList( this._designation, this._userName, this._IdBeneficiary, this._IdDemand, this._natureDemand, this._sector, this._natureProject, this._isSend);

  DeList.withId(
      this._IdBeneficiary,
      this._IdDemand,
      this._natureProject,
      this._sector,
      this._natureDemand,
      this._synch,
      this._designation,
      this._userName,
      this._isSend);

  int get idBeneficiary => _IdBeneficiary;

  int get idDemand => _IdDemand;

  int get natureRequestId => _natureDemand;

  int get sectorId => _sector;

  int get natureProjectId => _natureProject;

  int get synch => _synch;

  String get designation => _designation;

  // ignore: non_constant_identifier_names
  String get Name => _userName;

  String get isSend => _isSend;


  set synch(int newsynch) {
    this._synch = newsynch;
  }

  set designation(String newDesignation) {
    if (newDesignation.length <= 255) {
      this._designation = newDesignation;
    }
  }

  // ignore: non_constant_identifier_names
  set Name(String newUsername) {
    if (newUsername.length <= 255) {
      this._userName = newUsername;
    }
  }

  set isSend(String newisSend) {
    this._isSend = newisSend;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['idBeneficiary'] = _IdBeneficiary;
    map['idDemand'] = _IdDemand;
    map['natureRequestId'] = _natureDemand;
    map['sectorId'] = _sector;
    map['natureProjectId'] = _natureProject;
    map['synch'] = _synch;
    map['designation'] = _designation;
    map['Name'] = _userName;
    map['isSend'] = _isSend;

    return map;
  }

  // Extract a Note object from a Map object
  DeList.fromMapObject(Map<String, dynamic> map) {

    this._IdBeneficiary = map['idBeneficiary'];
    this._IdDemand = map['idDemand'];
    this._natureDemand = map['natureRequestId'];
    this._sector = map['sectorId'];
    this._natureProject = map['natureProjectId'];
    this._synch = map['synch'];
    this._designation = map['designation'];
    this._userName = map['Name'];
    this._isSend = map['isSend'];
  }
}
