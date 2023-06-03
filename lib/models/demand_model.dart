class Demand {
  int _id;
  int _synch;
  // ignore: non_constant_identifier_names
  int _entiteId_;
  // ignore: non_constant_identifier_names
  int _userId_;
  // ignore: non_constant_identifier_names
  int _state_;
  // ignore: non_constant_identifier_names
  String _synchDate_;
  String _code;
  String _designation;
  String _description;
  int _beneficiary;
  int _natureDemand;
  int _prospector;
  int _sector;
  int _natureProject;
  int _responsible;
  int _reasonRejectId;
  String _dateSend;
  String _isSend;
  int _idMobile;

  Demand(
      this._code,
      this._designation,
      this._description,
      this._beneficiary,
      this._natureDemand,
      this._prospector,
      this._sector,
      this._natureProject,
      this._userId_,
      this._synchDate_,
      this._entiteId_,
      this._responsible,
      this._dateSend,
      this._idMobile,
      this._isSend,
      this._reasonRejectId,
      this._state_,
      this._synch);

  Demand.withId(
    this._id,
    this._code,
    this._designation,
    this._description,
    this._beneficiary,
    this._natureDemand,
    this._prospector,
    this._sector,
    this._natureProject,
    this._userId_,
    this._synchDate_,
    this._entiteId_,
    this._responsible,
    this._dateSend,
    this._idMobile,
    this._isSend,
    this._reasonRejectId,
    this._state_,
    this._synch,
  );

  int get id => _id;
  int get synch => _synch;
  // ignore: non_constant_identifier_names
  int get entiteId_ => _entiteId_;
  // ignore: non_constant_identifier_names
  int get userId_ => _userId_;
  // ignore: non_constant_identifier_names
  int get state_ => _state_;
  // ignore: non_constant_identifier_names
  String get synchDate_ => _synchDate_;
  int get reasonRejectId => _reasonRejectId;
  String get dateSend => _dateSend;
  String get isSend => _isSend;
  int get idMobile => _idMobile;
  String get code => _code;
  String get designation => _designation;
  String get description => _description;
  int get beneficiaryId => _beneficiary;
  int get natureRequestId => _natureDemand;
  int get prospectorId => _prospector;
  int get sectorId => _sector;
  int get natureProjectId => _natureProject;
  int get responsibleId => _responsible;

  set id(int newId) {
    this._id = newId;
  }

  set synch(int newsynch) {
    this._synch = newsynch;
  }

  // ignore: non_constant_identifier_names
  set entiteId_(int newentiteId) {
    this._entiteId_ = newentiteId;
  }

  // ignore: non_constant_identifier_names
  set userId_(int newuserId) {
    this._userId_ = newuserId;
  }

  // ignore: non_constant_identifier_names
  set state_(int newstate) {
    this._state_ = newstate;
  }

  // ignore: non_constant_identifier_names
  set synchDate_(String newsynchDate) {
    this._synchDate_ = newsynchDate;
  }

  set reasonRejectId(int newreasonRejectId) {
    this._reasonRejectId = newreasonRejectId;
  }

  set dateSend(String newsdateSend) {
    this._dateSend = newsdateSend;
  }

  set isSend(String newisSend) {
    this._isSend = newisSend;
  }

  set idMobile(int newidMobile) {
    this._idMobile = newidMobile;
  }

  set code(String newCode) {
    this._code = newCode;
  }

  set designation(String newDesignation) {
    this._designation = newDesignation;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set beneficiaryId(int newBeneficiary) {
    this._beneficiary = newBeneficiary;
  }

  set natureRequestId(int newNatureDemand) {
    this._natureDemand = newNatureDemand;
  }

  set prospectorId(int newProspector) {
    this._prospector = newProspector;
  }

  set sectorId(int newSector) {
    this._sector = newSector;
  }

  set natureProjectId(int newNatureProject) {
    this._natureProject = newNatureProject;
  }

  set responsibleId(int newResponsible) {
    this._responsible = newResponsible;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['synch'] = _synch;
    map['entiteId_'] = _entiteId_;
    map['userId_'] = _userId_;
    map['state_'] = _state_;
    map['synchDate_'] = _synchDate_;
    map['code'] = _code;
    map['designation'] = _designation;
    map['description'] = _description;
    map['beneficiaryId'] = _beneficiary;
    map['natureRequestId'] = _natureDemand;
    map['prospectorId'] = _prospector;
    map['sectorId'] = _sector;
    map['natureProjectId'] = _natureProject;
    map['responsibleId'] = _responsible;
    map['reasonRejectId'] = _reasonRejectId;
    map['dateSend'] = _dateSend;
    map['isSend'] = _isSend;
    map['idMobile'] = _idMobile;

    return map;
  }

  // Extract a Note object from a Map object
  Demand.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._synch = map['synch'];
    this._entiteId_ = map['entiteId_'];
    this._userId_ = map['userId_'];
    this._state_ = map['state_'];
    this._synchDate_ = map['synchDate_'];
    this._code = map['code'];
    this._designation = map['designation'];
    this._description = map['description'];
    this._beneficiary = map['beneficiaryId'];
    this._natureDemand = map['natureRequestId'];
    this._prospector = map['prospectorId'];
    this._sector = map['sectorId'];
    this._natureProject = map['natureProjectId'];
    this._responsible = map['responsibleId'];
    this._reasonRejectId = map['reasonRejectId'];
    this._dateSend = map['dateSend'];
    this._isSend = map['isSend'];
    this._idMobile = map['idMobile'];
  }

  Demand.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    json['isSynchronized'] == null ? this._synch = json['isSynchronized']
    : this._synch = int.parse(json['isSynchronized']);
    this._entiteId_ = json['entiteId_'];
    this._userId_ = json['userId_'];
    this._state_ = json['state_'];
    this._synchDate_ = json['synchronizationDate_'];
    this._synchDate_ = json['synchDate_'];
    this._synchDate_ = json['synchronizationDate_'];
    this._code = json['code'];
    this._designation = json['designation'];
    this._description = json['description'];
    //this._beneficiary = int.parse(json['beneficiaireId']);
    this._beneficiary = json['beneficiaireId'];
    this._natureDemand = json['natureDemandeId'];
    this._prospector = json['prospecteurId'];
    this._sector = json['secteurId'];
    this._natureProject = json['natureProjetId'];
    this._responsible = json['responsableId'];
    this._reasonRejectId = json['motifRejetId'];
    this._dateSend = json['dateSend'];
    this._isSend = json['isFromDevice'];
    this._idMobile = json['idMobile'];
  }
  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['id'] = _id;
    json['isSynchronized'] = _synch;
    json['entiteId_'] = _entiteId_;
    json['userId_'] = _userId_;
    json['state_'] = _state_;
    json['synchronizationDate_'] = _synchDate_;
    json['code'] = _code;
    json['designation'] = _designation;
    json['description'] = _description;
    json['beneficiaireId'] = _beneficiary;
    json['natureDemandeId'] = _natureDemand;
    json['prospecteurId'] = _prospector;
    json['secteurId'] = _sector;
    json['natureProjetId'] = _natureProject;
    json['responsableId'] = _responsible;
    json['motifRejetId'] = _reasonRejectId;
    //json['dateSend'] = _dateSend;
    json['isFromDevice'] = _isSend;
    //json['idMobile'] = _idMobile;

    return json;
  }
}
