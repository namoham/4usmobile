class Payment {

  int _id;
  int _levelDelayPaymentId;
  int _actorId;
  // ignore: non_constant_identifier_names
  String _creationDate_;
  String _contractCode;
  String _codeTableDeadline;
  String _projectDesignation;
  double _totalAmount;
  double _amount;
  double _payrollAmount;
  double _unpaidAmount;
  int _numberDeadline;
  int _numberDayDelay;

  Payment(this._actorId, this._levelDelayPaymentId, this._creationDate_,this._contractCode, this._codeTableDeadline,
      this._projectDesignation, this._totalAmount, this._amount, this._payrollAmount, this._unpaidAmount,
      this._numberDeadline, this._numberDayDelay);

  Payment.withId(
      this._id,
      this._actorId, this._levelDelayPaymentId, this._creationDate_,this._contractCode, this._codeTableDeadline,
      this._projectDesignation, this._totalAmount, this._amount, this._payrollAmount, this._unpaidAmount,
      this._numberDeadline, this._numberDayDelay);

  int get id => _id;

  int get actorId => _actorId;

  int get levelDelayPaymentId => _levelDelayPaymentId;

  // ignore: non_constant_identifier_names
  String get creationDate_ => _creationDate_;

  String get contractCode => _contractCode;

  String get codeTableDeadline => _codeTableDeadline;

  String get projectDesignation => _projectDesignation;

  double get totalAmount => _totalAmount;

  double get amount => _amount;

  double get payrollAmount => _payrollAmount;

  double get unpaidAmount => _unpaidAmount;

  int get numberDeadline => _numberDeadline;

  int get numberDayDelay => _numberDayDelay;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['actorId'] = _actorId;
    map['levelDelayPaymentId'] = _levelDelayPaymentId;
    map['creationDate_'] = _creationDate_;
    map['contractCode'] = _contractCode;
    map['codeTableDeadline'] = _codeTableDeadline;
    map['projectDesignation'] = _projectDesignation;
    map['totalAmount'] = _totalAmount;
    map['amount'] = _amount;
    map['payrollAmount'] = _payrollAmount;
    map['unpaidAmount'] = _unpaidAmount;
    map['numberDeadline'] = _numberDeadline;
    map['numberDayDelay'] = _numberDayDelay;

    return map;
  }

  Payment.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._actorId = map['actorId'];
    this._levelDelayPaymentId = map['levelDelayPaymentId'];
    this._creationDate_ = map['creationDate_'];
    this._contractCode = map['contractCode'];
    this._codeTableDeadline = map['codeTableDeadline'];
    if (this._codeTableDeadline == null){
      this._codeTableDeadline = '';
    }
    this._projectDesignation = map['projectDesignation'];
    this._totalAmount = map['totalAmount'];
    this._amount = map['amount'];
    this._payrollAmount = map['payrollAmount'];
    this._unpaidAmount = map['unpaidAmount'];
    this._numberDeadline = map['numberDeadline'];
    this._numberDayDelay = map['numberDayDelay'];
  }

  Payment.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._levelDelayPaymentId = json['levelDelayPaymentId'];
    this._actorId = json['actorId'];
    this._creationDate_ = json['creationDate'];
    this._contractCode = json['contractCode'];
    this._codeTableDeadline = json['codeTableDeadline'];
    this._projectDesignation = json['projectDesignation'];
    this._totalAmount = json['totalAmount'];
    this._amount = json['amount'];
    this._payrollAmount = json['payrollAmount'];
    this._unpaidAmount = json['unpaidAmount'];
    this._numberDeadline = json['numberDeadline'];
    this._numberDayDelay = json['numberDayDelay'];
  }
}