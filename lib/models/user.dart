class User {
  int _id;
  int _synch;
  int _state;
  // ignore: non_constant_identifier_names
  int _userId_;
  int _entiteId_;
  int _userType;
  int _sex;
  int _nationality;
  int _activity;
  int _identityType;
  int _studyLevel;
  int _povertyDegree;
  int _profession;
  int _occupation;
  int _familySituation;
  int _familyResources;
  int _regionAddress;
  int _provinceAddress;
  int _localityAddress;
  int _regionBusinessAddress;
  int _provinceBusinessAddress;
  int _localityBusinessAddress;
  int _sectorId;
  int _fonctionUserId;
  int _CategorySupplierId;
  int _typeCompanyId;
  int _typeAuthenticationUserId;
  int _localityId;
  int _idMobile;
  String _image;
  String _username;
  String _password;
  String _firstname;
  String _secondname;
  String _thirdname;
  String _fourthname;
  String _name;
  String _arabicName;
  String _birthdate;
  String _birthplace;
  String _arabicBirthplace;
  String _information;
  String _bankaccount;
  String _legacy;
  String _numberChildrenCharge;
  String _numberChildrenSchoolers;
  String _spouseactivity;
  String _identity;
  String _deliverydate;
  String _deliveryplace;
  String _arabicDeliveryplace;
  String _dateEndValidity;
  String _additionalAdresse;
  String _arabicAdditionalAdresse;
  String _mapsAddress;
  String _additionalBusinessAddress;
  String _arabicAdditionalBusinessAddress;
  String _mapsCordsBusinessAddress;
  String _telephone;
  String _telephoneTwo;
  String _email;
  String _fax;
  String _monthly_income;
  String _AverageIndividualExpensePerDay;
  String _officeCredit;
  String _blackList;
  String _blackListDate;
  String _ExternalFunding;
  String _authorizationCode;
  String _Creation_place;
  String _codeCertificateRegistration;
  String _date_Delivery_Certificate;
  String _codeLow;
  String _dateLow;
  String _Member_number;
  String _member_number_flag;
  String _Social_reason;
  String _externalCode;
  String _currency;
  String _logo;
  String _oldPassword;
  String _newPassword;
  String _confirmNewPassword;
  String _Current_Id_role;
  String _question;
  String _reply;
  String _numberMaleMember;
  String _numberFemaleMember;
  String _max_Contract_in_Execution;
  String _maxContractApprovalReserve;
  String _maxBudgetReserve;
  String _temporaryPassword;
  String _addDepot;
  String _numberFamily;
  String _Calculated_name;
  String _number_order;
  String _typeContrat;
  String _Social_Guarantee;
  String _No_MaxGuarantee;
  String _AmountMax_Guarantee;
  String _tax_code;
  String _capital;
  String _is_doubtful;
  String _numberNewCustomer;
  String _dateRecruitment;
  String _old_customer_number;
  String _amountDisbursement;
  String _dateEndContract;
  String _synchDate_;
  String _isFromDevice;
  String _byAgence;
  String _code;
  String _dateSend;
  String _isSend;

  User(
      this._state,
      this._synch,
      this._entiteId_,
      this._userId_,
      this._userType,
      this._sex,
      this._nationality,
      this._activity,
      this._identityType,
      this._studyLevel,
      this._povertyDegree,
      this._profession,
      this._occupation,
      this._familySituation,
      this._familyResources,
      this._regionAddress,
      this._provinceAddress,
      this._localityAddress,
      this._regionBusinessAddress,
      this._provinceBusinessAddress,
      this._localityBusinessAddress,
      this._CategorySupplierId,
      this._fonctionUserId,
      this._localityId,
      this._sectorId,
      this._typeAuthenticationUserId,
      this._typeCompanyId,
      this._idMobile,
      this._byAgence,
      this._mapsAddress,
      this._image,
      this._username,
      this._password,
      this._firstname,
      this._secondname,
      this._thirdname,
      this._fourthname,
      this._name,
      this._arabicName,
      this._birthdate,
      this._birthplace,
      this._arabicBirthplace,
      this._information,
      this._bankaccount,
      this._legacy,
      this._numberChildrenCharge,
      this._numberChildrenSchoolers,
      this._spouseactivity,
      this._identity,
      this._deliverydate,
      this._deliveryplace,
      this._arabicDeliveryplace,
      this._dateEndValidity,
      this._additionalAdresse,
      this._arabicAdditionalAdresse,
      this._additionalBusinessAddress,
      this._arabicAdditionalBusinessAddress,
      this._mapsCordsBusinessAddress,
      this._telephone,
      this._telephoneTwo,
      this._email,
      this._fax,
      this._monthly_income,
      this._AverageIndividualExpensePerDay,
      this._officeCredit,
      this._blackList,
      this._blackListDate,
      this._ExternalFunding,
      this._authorizationCode,
      this._code,
      this._addDepot,
      this._amountDisbursement,
      this._AmountMax_Guarantee,
      this._Calculated_name,
      this._capital,
      this._codeCertificateRegistration,
      this._codeLow,
      this._confirmNewPassword,
      this._Creation_place,
      this._currency,
      this._Current_Id_role,
      this._date_Delivery_Certificate,
      this._dateEndContract,
      this._dateLow,
      this._dateRecruitment,
      this._externalCode,
      this._is_doubtful,
      this._isFromDevice,
      this._logo,
      this._max_Contract_in_Execution,
      this._maxBudgetReserve,
      this._maxContractApprovalReserve,
      this._Member_number,
      this._member_number_flag,
      this._newPassword,
      this._No_MaxGuarantee,
      this._number_order,
      this._numberFamily,
      this._numberFemaleMember,
      this._numberMaleMember,
      this._numberNewCustomer,
      this._old_customer_number,
      this._oldPassword,
      this._question,
      this._reply,
      this._Social_Guarantee,
      this._Social_reason,
      this._synchDate_,
      this._tax_code,
      this._temporaryPassword,
      this._typeContrat,
      this._dateSend,
      this._isSend);

  User.withId(
      this._id,
      this._state,
      this._synch,
      this._entiteId_,
      this._userId_,
      this._userType,
      this._sex,
      this._nationality,
      this._activity,
      this._identityType,
      this._studyLevel,
      this._povertyDegree,
      this._profession,
      this._occupation,
      this._familySituation,
      this._familyResources,
      this._regionAddress,
      this._provinceAddress,
      this._localityAddress,
      this._regionBusinessAddress,
      this._provinceBusinessAddress,
      this._localityBusinessAddress,
      this._CategorySupplierId,
      this._fonctionUserId,
      this._localityId,
      this._sectorId,
      this._typeAuthenticationUserId,
      this._typeCompanyId,
      this._idMobile,
      this._byAgence,
      this._mapsAddress,
      this._image,
      this._username,
      this._password,
      this._firstname,
      this._secondname,
      this._thirdname,
      this._fourthname,
      this._name,
      this._arabicName,
      this._birthdate,
      this._birthplace,
      this._arabicBirthplace,
      this._information,
      this._bankaccount,
      this._legacy,
      this._numberChildrenCharge,
      this._numberChildrenSchoolers,
      this._spouseactivity,
      this._identity,
      this._deliverydate,
      this._deliveryplace,
      this._arabicDeliveryplace,
      this._dateEndValidity,
      this._additionalAdresse,
      this._arabicAdditionalAdresse,
      this._additionalBusinessAddress,
      this._arabicAdditionalBusinessAddress,
      this._mapsCordsBusinessAddress,
      this._telephone,
      this._telephoneTwo,
      this._email,
      this._fax,
      this._monthly_income,
      this._AverageIndividualExpensePerDay,
      this._officeCredit,
      this._blackList,
      this._blackListDate,
      this._ExternalFunding,
      this._authorizationCode,
      this._code,
      this._addDepot,
      this._amountDisbursement,
      this._AmountMax_Guarantee,
      this._Calculated_name,
      this._capital,
      this._codeCertificateRegistration,
      this._codeLow,
      this._confirmNewPassword,
      this._Creation_place,
      this._currency,
      this._Current_Id_role,
      this._date_Delivery_Certificate,
      this._dateEndContract,
      this._dateLow,
      this._dateRecruitment,
      this._externalCode,
      this._is_doubtful,
      this._isFromDevice,
      this._logo,
      this._max_Contract_in_Execution,
      this._maxBudgetReserve,
      this._maxContractApprovalReserve,
      this._Member_number,
      this._member_number_flag,
      this._newPassword,
      this._No_MaxGuarantee,
      this._number_order,
      this._numberFamily,
      this._numberFemaleMember,
      this._numberMaleMember,
      this._numberNewCustomer,
      this._old_customer_number,
      this._oldPassword,
      this._question,
      this._reply,
      this._Social_Guarantee,
      this._Social_reason,
      this._synchDate_,
      this._tax_code,
      this._temporaryPassword,
      this._typeContrat,
      this._dateSend,
      this._isSend);

  int get id => _id;

  int get synch => _synch;

  int get state_ => _state;

  int get entiteId_ => _entiteId_;

  int get userId_ => _userId_;

  int get typeActorId => _userType;

  int get sexId => _sex;

  int get nationalityId => _nationality;

  int get activityActorId => _activity;

  int get typeIdentityId => _identityType;

  int get StudyLevelId => _studyLevel;

  int get DegreePovertyId => _povertyDegree;

  int get professionId => _profession;

  int get typeOccupationId => _occupation;

  int get situationFamilyId => _familySituation;

  int get resourcesFamilyId => _familyResources;

  int get regionAdresse => _regionAddress;

  int get provinceAddress => _provinceAddress;

  int get localityAddress => _localityAddress;

  int get regionBusinessAddress => _regionBusinessAddress;

  int get provinceBusinessAddress => _provinceBusinessAddress;

  int get localityBusinessAddress => _localityBusinessAddress;

  int get sectorId => _sectorId;

  int get fonctionUserId => _fonctionUserId;

  int get CategorySupplierId => _CategorySupplierId;

  int get typeCompanyId => _typeCompanyId;

  int get typeAuthenticationUserId => _typeAuthenticationUserId;

  int get localityId => _localityId;

  int get idMobile => _idMobile;

  String get login => _username;

  String get photo => _image;

  String get password => _password;

  String get firstName => _firstname;

  String get middleName => _secondname;

  String get thirdName => _thirdname;

  String get fourthName => _fourthname;

  String get Name => _name;

  String get NameDL => _arabicName;

  String get Birth_Date => _birthdate;

  String get Birth_Place => _birthplace;

  String get BirthplaceDL => _arabicBirthplace;

  String get information => _information;

  String get Bank_account => _bankaccount;

  String get legacy => _legacy;

  String get numberChildrenCharge => _numberChildrenCharge;

  String get numberChildrenSchoolers => _numberChildrenSchoolers;

  String get Spouse_activity => _spouseactivity;

  String get identity_ => _identity;

  String get Delivery_date => _deliverydate;

  String get Delivery_place => _deliveryplace;

  String get placeDeliveryDL => _arabicDeliveryplace;

  String get dateEndValidity => _dateEndValidity;

  String get additionalAdresse => _additionalAdresse;

  String get additionalDLAddress => _arabicAdditionalAdresse;

  String get mapsAddress => _mapsAddress;

  String get additionalBusinessAddress => _additionalBusinessAddress;

  String get additionalDLBusinessAddress => _arabicAdditionalBusinessAddress;

  String get mapsCordsBusinessAddress => _mapsCordsBusinessAddress;

  String get telephone => _telephone;

  String get telephoneTwo => _telephoneTwo;

  String get email => _email;

  String get fax => _fax;

  String get monthly_income => _monthly_income;

  String get AverageIndividualExpensePerDay => _AverageIndividualExpensePerDay;

  String get OfficeCredit => _officeCredit;

  String get blackList => _blackList;

  String get blackListDate => _blackListDate;

  String get External_funding => _ExternalFunding;

  String get authorizationCode => _authorizationCode;

  String get code => _code;

  String get addDepot => _addDepot;

  String get amountDisbursement => _amountDisbursement;

  String get AmountMax_Guarantee => _AmountMax_Guarantee;

  String get byAgence => _byAgence;

  String get Calculated_name => _Calculated_name;

  String get capital => _capital;

  String get codeCertificateRegistration => _codeCertificateRegistration;

  String get codeLow => _codeLow;

  String get confirmNewPassword => _confirmNewPassword;

  String get Creation_place => _Creation_place;

  String get currency => _currency;

  String get Current_Id_role => _Current_Id_role;

  String get date_Delivery_Certificate => _date_Delivery_Certificate;

  String get dateEndContract => _dateEndContract;

  String get dateLow => _dateLow;

  String get dateRecruitment => _dateRecruitment;

  String get External_code => _externalCode;

  String get is_doubtful => _is_doubtful;

  String get isFromDevice => _isFromDevice;

  String get logo => _logo;

  String get max_Contract_in_Execution => _max_Contract_in_Execution;

  String get maxContractApprovalReserve => _maxContractApprovalReserve;

  String get Member_number => _Member_number;

  String get member_number_flag => _member_number_flag;

  String get newPassword => _newPassword;

  String get No_MaxGuarantee => _No_MaxGuarantee;

  String get number_order => _number_order;

  String get numberFamily => _numberFamily;

  String get numberFemaleMember => _numberFemaleMember;

  String get numberMaleMember => _numberMaleMember;

  String get numberNewCustomer => _numberNewCustomer;

  String get old_customer_number => _old_customer_number;

  String get oldPassword => _oldPassword;

  String get question => _question;

  String get reply => _reply;

  String get Social_Guarantee => _Social_Guarantee;

  String get Social_reason => _Social_reason;

  String get synchDate_ => _synchDate_;

  String get tax_code => _tax_code;

  String get maxBudgetReserve => _maxBudgetReserve;

  String get temporaryPassword => _temporaryPassword;

  String get typeContrat => _typeContrat;

  String get dateSend => _dateSend;

  String get isSend => _isSend;

  set id(int newId) {
    this._id = newId;
  }

  set state_(int newState_) {
    this._state = newState_;
  }

  set synch(int newSynch) {
    this._synch = newSynch;
  }

  set entiteId_(int newentiteId_) {
    this._entiteId_ = newentiteId_;
  }

  set userId_(int newuserId_) {
    this._userId_ = newuserId_;
  }

  set typeActorId(int newtypeActorId) {
    this._userType = newtypeActorId;
  }

  set sexId(int newSexId) {
    this._sex = newSexId;
  }

  set nationalityId(int newNationalityId) {
    this._nationality = newNationalityId;
  }

  set activityActorId(int newActivityId) {
    this._activity = newActivityId;
  }

  set typeIdentityId(int newtypeIdentityId) {
    this._identityType = newtypeIdentityId;
  }

  set StudyLevelId(int newStudyLevelId) {
    this._studyLevel = newStudyLevelId;
  }

  set DegreePovertyId(int newDegreePovertyId) {
    this._povertyDegree = newDegreePovertyId;
  }

  set professionId(int newprofessionId) {
    this._profession = newprofessionId;
  }

  set typeOccupationId(int newtypeOccupationId) {
    this._occupation = newtypeOccupationId;
  }

  set situationFamilyId(int newsituationFamilyId) {
    this._familySituation = newsituationFamilyId;
  }

  set resourcesFamilyId(int newresourcesFamilyId) {
    this._familyResources = newresourcesFamilyId;
  }

  set regionAdresse(int newRegionAdresse) {
    this._regionAddress = newRegionAdresse;
  }

  set provinceAddress(int newProvinceAddress) {
    this._provinceAddress = newProvinceAddress;
  }

  set localityAddress(int newLocalityAddress) {
    this._localityAddress = newLocalityAddress;
  }

  set regionBusinessAddress(int newRegionBusinessAddress) {
    this._regionBusinessAddress = newRegionBusinessAddress;
  }

  set provinceBusinessAddress(int newProvinceBusinessAddress) {
    this._provinceBusinessAddress = newProvinceBusinessAddress;
  }

  set localityBusinessAddress(int newLocalityBusinessAddress) {
    this._localityBusinessAddress = newLocalityBusinessAddress;
  }

  set sectorId(int newsectorId) {
    this._sectorId = newsectorId;
  }

  set fonctionUserId(int newfonctionUserId) {
    this._fonctionUserId = newfonctionUserId;
  }

  set CategorySupplierId(int newCategorySupplierId) {
    this._CategorySupplierId = newCategorySupplierId;
  }

  set typeCompanyId(int newtypeCompanyId) {
    this._typeCompanyId = newtypeCompanyId;
  }

  set typeAuthenticationUserId(int newtypeAuthenticationUserId) {
    this._typeAuthenticationUserId = newtypeAuthenticationUserId;
  }

  set localityId(int newlocalityId) {
    this._localityId = newlocalityId;
  }

  set idMobile(int newidMobile) {
    this._idMobile = newidMobile;
  }

  set login(String newLogin) {
    this._username = newLogin;
  }

  set photo(String newPhoto) {
    this._image = newPhoto;
  }

  set password(String newPassword) {
    this._password = newPassword;
  }

  set firstName(String newFirstName) {
    this._firstname = newFirstName;
  }

  set middleName(String newMiddleName) {
    this._secondname = newMiddleName;
  }

  set thirdName(String newThirdName) {
    this._thirdname = newThirdName;
  }

  set fourthName(String newFourthName) {
    this._fourthname = newFourthName;
  }

  set Name(String newName) {
    this._name = newName;
  }

  set NameDL(String newNameDL) {
    this._arabicName = newNameDL;
  }

  set Birth_Date(String newBirth_Date) {
    this._birthdate = newBirth_Date;
  }

  set Birth_Place(String newBirth_Place) {
    this._birthplace = newBirth_Place;
  }

  set BirthplaceDL(String newBirthplaceDL) {
    this._arabicBirthplace = newBirthplaceDL;
  }

  set information(String newInformation) {
    this._information = newInformation;
  }

  set Bank_account(String newBank_account) {
    this._bankaccount = newBank_account;
  }

  set legacy(String newLegacy) {
    this._legacy = newLegacy;
  }

  set numberChildrenCharge(String newNumberChildrenCharge) {
    this._numberChildrenCharge = newNumberChildrenCharge;
  }

  set numberChildrenSchoolers(String newNumberChildrenSchoolers) {
    this._numberChildrenSchoolers = newNumberChildrenSchoolers;
  }

  set Spouse_activity(String newSpouse_activity) {
    this._spouseactivity = newSpouse_activity;
  }

  set identity_(String newIdentity) {
    this._identity = newIdentity;
  }

  set Delivery_date(String newDelivery_date) {
    this._deliverydate = newDelivery_date;
  }

  set Delivery_place(String newDelivery_place) {
    this._deliveryplace = newDelivery_place;
  }

  set placeDeliveryDL(String newplaceDeliveryDL) {
    this._arabicDeliveryplace = newplaceDeliveryDL;
  }

  set dateEndValidity(String newdateEndValidity) {
    this._dateEndValidity = newdateEndValidity;
  }

  set additionalAdresse(String newAdditionalAdresse) {
    this._additionalAdresse = newAdditionalAdresse;
  }

  set additionalDLAddress(String newAdditionalDLAddress) {
    this._arabicAdditionalAdresse = newAdditionalDLAddress;
  }

  set mapsAddress(String newMapsAddress) {
    this._mapsAddress = newMapsAddress;
  }

  set additionalBusinessAddress(String newAdditionalBusinessAddress) {
    this._additionalBusinessAddress = newAdditionalBusinessAddress;
  }

  set additionalDLBusinessAddress(String newAdditionalDLBusinessAddress) {
    this._arabicAdditionalBusinessAddress = newAdditionalDLBusinessAddress;
  }

  set mapsCordsBusinessAddress(String newMapsCordsBusinessAddress) {
    this._mapsCordsBusinessAddress = newMapsCordsBusinessAddress;
  }

  set telephone(String newTelephone) {
    this._telephone = newTelephone;
  }

  set telephoneTwo(String newTelephoneTwo) {
    this._telephoneTwo = newTelephoneTwo;
  }

  set email(String newEmail) {
    this._email = newEmail;
  }

  set fax(String newFax) {
    this._fax = newFax;
  }

  set monthly_income(String newMonthly_income) {
    this._monthly_income = newMonthly_income;
  }

  set AverageIndividualExpensePerDay(String newAverageIndividualExpensePerDay) {
    this._AverageIndividualExpensePerDay = newAverageIndividualExpensePerDay;
  }

  set OfficeCredit(String newOfficeCredit) {
    this._officeCredit = newOfficeCredit;
  }

  set blackList(String newblackList) {
    this._blackList = newblackList;
  }

  set blackListDate(String newblackListDate) {
    this._blackListDate = newblackListDate;
  }

  set External_funding(String newExternal_funding) {
    this._ExternalFunding = newExternal_funding;
  }

  set authorizationCode(String newAuthorizationCode) {
    this._authorizationCode = newAuthorizationCode;
  }

  set code(String newcode) {
    this._code = newcode;
  }

  set addDepot(String newaddDepot) {
    this._addDepot = newaddDepot;
  }

  set amountDisbursement(String newamountDisbursement) {
    this._amountDisbursement = newamountDisbursement;
  }

  set AmountMax_Guarantee(String newAmountMax_Guarantee) {
    this._AmountMax_Guarantee = newAmountMax_Guarantee;
  }

  set byAgence(String newbyAgence) {
    this._byAgence = newbyAgence;
  }

  set Calculated_name(String newCalculated_name) {
    this._Calculated_name = newCalculated_name;
  }

  set capital(String newcapital) {
    this._capital = newcapital;
  }

  set codeCertificateRegistration(String newcodeCertificateRegistration) {
    this._codeCertificateRegistration = newcodeCertificateRegistration;
  }

  set codeLow(String newcodeLow) {
    this._codeLow = newcodeLow;
  }

  set confirmNewPassword(String newconfirmNewPassword) {
    this._confirmNewPassword = newconfirmNewPassword;
  }

  set Creation_place(String newCreationPlace) {
    this._Creation_place = newCreationPlace;
  }

  set currency(String newcurrency) {
    this._currency = newcurrency;
  }

  set Current_Id_role(String newCurrent_Id_role) {
    this._Current_Id_role = newCurrent_Id_role;
  }

  set date_Delivery_Certificate(String newdate_Delivery_Certificate) {
    this._date_Delivery_Certificate = newdate_Delivery_Certificate;
  }

  set dateEndContract(String newdateEndContract) {
    this._dateEndContract = newdateEndContract;
  }

  set dateLow(String newdateLow) {
    this._dateLow = newdateLow;
  }

  set dateRecruitment(String newdateRecruitment) {
    this._dateRecruitment = newdateRecruitment;
  }

  set External_code(String newExternal_code) {
    this._externalCode = newExternal_code;
  }

  set is_doubtful(String newis_doubtful) {
    this._is_doubtful = newis_doubtful;
  }

  set isFromDevice(String newisFromDevice) {
    this._isFromDevice = newisFromDevice;
  }

  set logo(String newlogo) {
    this._logo = newlogo;
  }

  set max_Contract_in_Execution(String newmax_Contract_in_Execution) {
    this._max_Contract_in_Execution = newmax_Contract_in_Execution;
  }

  set maxBudgetReserve(String newmaxBudgetReserve) {
    this._maxBudgetReserve = newmaxBudgetReserve;
  }

  set maxContractApprovalReserve(String newmaxContractApprovalReserve) {
    this._maxContractApprovalReserve = newmaxContractApprovalReserve;
  }

  set Member_number(String newMember_number) {
    this._Member_number = newMember_number;
  }

  set member_number_flag(String newmember_number_flag) {
    this._member_number_flag = newmember_number_flag;
  }

  set newPassword(String newNewPassword) {
    this._newPassword = newNewPassword;
  }

  set No_MaxGuarantee(String newNo_MaxGuarantee) {
    this._No_MaxGuarantee = newNo_MaxGuarantee;
  }

  set number_order(String newnumber_order) {
    this._number_order = newnumber_order;
  }

  set numberFamily(String newnumberFamily) {
    this._numberFamily = newnumberFamily;
  }

  set numberFemaleMember(String newnumberFemaleMember) {
    this._numberFemaleMember = newnumberFemaleMember;
  }

  set numberMaleMember(String newnumberMaleMember) {
    this._numberMaleMember = newnumberMaleMember;
  }

  set numberNewCustomer(String newnumberNewCustomer) {
    this._numberNewCustomer = newnumberNewCustomer;
  }

  set old_customer_number(String newold_customer_number) {
    this._old_customer_number = newold_customer_number;
  }

  set oldPassword(String newoldPassword) {
    this._oldPassword = newoldPassword;
  }

  set question(String newquestion) {
    this._question = newquestion;
  }

  set reply(String newreply) {
    this._reply = newreply;
  }

  set Social_Guarantee(String newSocial_Guarantee) {
    this._Social_Guarantee = newSocial_Guarantee;
  }

  set Social_reason(String newSocial_reason) {
    this._Social_reason = newSocial_reason;
  }

  set synchDate_(String newsynchDate_) {
    this._synchDate_ = newsynchDate_;
  }

  set tax_code(String newtax_code) {
    this._tax_code = newtax_code;
  }

  set temporaryPassword(String newtemporaryPassword) {
    this._temporaryPassword = newtemporaryPassword;
  }

  set typeContrat(String newtypeContrat) {
    this._typeContrat = newtypeContrat;
  }

  set dateSend(String newdateSend) {
    this._dateSend = newdateSend;
  }

  set isSend(String newisSend) {
    this._isSend = newisSend;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['synch'] = _synch;
    map['state_'] = _state;
    map['userId_'] = _userId_;
    map['typeActorId'] = _userType;
    map['sexId'] = _sex;
    map['nationalityId'] = _nationality;
    map['activityActorId'] = _activity;
    map['typeIdentityId'] = _identityType;
    map['StudyLevelId'] = _studyLevel;
    map['DegreePovertyId'] = _povertyDegree;
    map['professionId'] = _profession;
    map['typeOccupationId'] = _occupation;
    map['situationFamilyId'] = _familySituation;
    map['resourcesFamilyId'] = _familyResources;
    map['sectorId'] = _sectorId;
    map['fonctionUserId'] = _fonctionUserId;
    map['CategorySupplierId'] = _CategorySupplierId;
    map['typeCompanyId'] = _typeCompanyId;
    map['typeAuthenticationUserId'] = _typeAuthenticationUserId;
    map['localityId'] = _localityId;
    map['idMobile'] = _idMobile;
    map["login"] = _username;
    map["password"] = _password;
    map["photo"] = _image;
    map["firstName"] = _firstname;
    map["middleName"] = _secondname;
    map["thirdName"] = _thirdname;
    map["fourthName"] = _fourthname;
    map["Name"] = _name;
    map["NameDL"] = _arabicName;
    map["Birth_Date"] = _birthdate;
    map["Birth_Place"] = _birthplace;
    map["BirthplaceDL"] = _arabicBirthplace;
    map["information"] = _information;
    map["Bank_account"] = _bankaccount;
    map["legacy"] = _legacy;
    map["numberChildrenCharge"] = _numberChildrenCharge;
    map["numberChildrenSchoolers"] = _numberChildrenSchoolers;
    map["Spouse_activity"] = _spouseactivity;
    map["identity_"] = _identity;
    map["Delivery_date"] = _deliverydate;
    map["Delivery_place"] = _deliveryplace;
    map["placeDeliveryDL"] = _arabicDeliveryplace;
    map["dateEndValidity"] = _dateEndValidity;
    map["regionAdresse"] = _regionAddress;
    map["provinceAddress"] = _provinceAddress;
    map["localityAddress"] = _localityAddress;
    map["additionalAdresse"] = _additionalAdresse;
    map["additionalDLAddress"] = _arabicAdditionalAdresse;
    map["mapsAddress"] = _mapsAddress;
    map["regionBusinessAddress"] = _regionBusinessAddress;
    map["provinceBusinessAddress"] = _provinceBusinessAddress;
    map["localityBusinessAddress"] = _localityBusinessAddress;
    map["additionalBusinessAddress"] = _additionalBusinessAddress;
    map["additionalDLBusinessAddress"] = _arabicAdditionalBusinessAddress;
    map["mapsCordsBusinessAddress"] = _mapsCordsBusinessAddress;
    map["telephone"] = _telephone;
    map["telephoneTwo"] = _telephoneTwo;
    map["email"] = _email;
    map["fax"] = _fax;
    map["monthly_income"] = _monthly_income;
    map["AverageIndividualExpensePerDay"] = _AverageIndividualExpensePerDay;
    map["OfficeCredit"] = _officeCredit;
    map["blackList"] = _blackList;
    map["blackListDate"] = _blackListDate;
    map["External_funding"] = _ExternalFunding;
    map["authorizationCode"] = _authorizationCode;
    map["code"] = _code;
    map["addDepot"] = _addDepot;
    map["amountDisbursement"] = _amountDisbursement;
    map["AmountMax_Guarantee"] = _AmountMax_Guarantee;
    map["byAgence"] = _byAgence;
    map["Calculated_name"] = _Calculated_name;
    map["capital"] = _capital;
    map["codeCertificateRegistration"] = _codeCertificateRegistration;
    map["codeLow"] = _codeLow;
    map["confirmNewPassword"] = _confirmNewPassword;
    map["Creation_place"] = _Creation_place;
    map["currency"] = _currency;
    map["Current_Id_role"] = _Current_Id_role;
    map["date_Delivery_Certificate"] = _date_Delivery_Certificate;
    map["dateEndContract"] = _dateEndContract;
    map["dateLow"] = _dateLow;
    map["dateRecruitment"] = _dateRecruitment;
    map["entiteId_"] = _entiteId_;
    map["External_code"] = _externalCode;
    map["is_doubtful"] = _is_doubtful;
    map["isFromDevice"] = _isFromDevice;
    map["logo"] = _logo;
    map["max_Contract_in_Execution"] = _max_Contract_in_Execution;
    map["maxBudgetReserve"] = _maxBudgetReserve;
    map["maxContractApprovalReserve"] = _maxContractApprovalReserve;
    map["Member_number"] = _Member_number;
    map["member_number_flag"] = _member_number_flag;
    map["newPassword"] = _newPassword;
    map["No_MaxGuarantee"] = _No_MaxGuarantee;
    map["number_order"] = _number_order;
    map["numberFamily"] = _numberFamily;
    map["numberFemaleMember"] = _numberFemaleMember;
    map["numberMaleMember"] = _numberMaleMember;
    map["numberNewCustomer"] = _numberNewCustomer;
    map["old_customer_number"] = _old_customer_number;
    map["oldPassword"] = _oldPassword;
    map["question"] = _question;
    map["reply"] = _reply;
    map["Social_Guarantee"] = _Social_Guarantee;
    map["Social_reason"] = _Social_reason;
    map["synchDate_"] = _synchDate_;
    map["tax_code"] = _tax_code;
    map["temporaryPassword"] = _temporaryPassword;
    map["typeContrat"] = _typeContrat;
    map["userId_"] = _userId_;
    map["dateSend"] = _dateSend;
    map["isSend"] = _isSend;

    return map;
  }

  User.fromMap(Map<String, dynamic> obj) {
    this._id = obj['id'];
    this._synch = obj['synch'];
    this._state = obj['state_'];
    this._userId_ = obj['userId_'];
    this._userType = obj['typeActorId'];
    this._sex = obj['sexId'];
    this._nationality = obj['nationalityId'];
    this._activity = obj['activityActorId'];
    this._identityType = obj['typeIdentityId'];
    this._studyLevel = obj['StudyLevelId'];
    this._povertyDegree = obj['DegreePovertyId'];
    this._profession = obj['professionId'];
    this._occupation = obj['typeOccupationId'];
    this._familySituation = obj['situationFamilyId'];
    this._familyResources = obj['resourcesFamilyId'];
    this._sectorId = obj['sectorId'];
    this._fonctionUserId = obj['fonctionUserId'];
    this._CategorySupplierId = obj['CategorySupplierId'];
    this._typeCompanyId = obj['typeCompanyId'];
    this._typeAuthenticationUserId = obj['typeAuthenticationUserId'];
    this._localityId = obj['localityId'];
    this._idMobile = obj['idMobile'];
    this._username = obj['login'];
    this._password = obj['password'];
    this._image = obj['photo'];
    this._firstname = obj['firstName'];
    this._secondname = obj['middleName'];
    this._thirdname = obj['thirdName'];
    this._fourthname = obj['fourthName'];
    this._name = obj['Name'];
    this._arabicName = obj['NameDL'];
    this._birthdate = obj['Birth_Date'];
    this._birthplace = obj['Birth_Place'];
    this._arabicBirthplace = obj['BirthplaceDL'];
    this._information = obj['information'];
    this._bankaccount = obj['Bank_account'];
    this._legacy = obj['legacy'];
    this._numberChildrenCharge = obj['numberChildrenCharge'];
    this._numberChildrenSchoolers = obj['numberChildrenSchoolers'];
    this._spouseactivity = obj['Spouse_activity'];
    this._identity = obj['identity_'];
    this._deliverydate = obj['Delivery_date'];
    this._deliveryplace = obj['Delivery_place'];
    this._arabicDeliveryplace = obj['placeDeliveryDL'];
    this._dateEndValidity = obj['dateEndValidity'];
    this._regionAddress = obj['regionAdresse'];
    this._provinceAddress = obj['provinceAddress'];
    this._localityAddress = obj['localityAddress'];
    this._additionalAdresse = obj['additionalAdresse'];
    this._arabicAdditionalAdresse = obj['additionalDLAddress'];
    this._mapsAddress = obj['mapsAddress'];
    this._regionBusinessAddress = obj['regionBusinessAddress'];
    this._provinceBusinessAddress = obj['provinceBusinessAddress'];
    this._localityBusinessAddress = obj['localityBusinessAddress'];
    this._additionalBusinessAddress = obj['additionalBusinessAddress'];
    this._arabicAdditionalBusinessAddress = obj['additionalDLBusinessAddress'];
    this._mapsCordsBusinessAddress = obj['mapsCordsBusinessAddress'];
    this._telephone = obj['telephone'];
    this._telephoneTwo = obj['telephoneTwo'];
    this._email = obj['email'];
    this._fax = obj['fax'];
    this._monthly_income = obj['monthly_income'];
    this._AverageIndividualExpensePerDay =
        obj['AverageIndividualExpensePerDay'];
    this._officeCredit = obj['OfficeCredit'];
    this._blackList = obj['blackList'];
    this._blackListDate = obj['blackListDate'];
    this._ExternalFunding = obj['External_funding'];
    this._authorizationCode = obj['authorizationCode'];
    this._code = obj['code'];
    this._addDepot = obj['addDepot'];
    this._amountDisbursement = obj['amountDisbursement'];
    this._AmountMax_Guarantee = obj['AmountMax_Guarantee'];
    /*if(obj['byAgence'] == 1){
      this._byAgence = true;
    }
    else if(obj['byAgence'] == 0){
      this._byAgence = false;
    }*/
    // obj['byAgence'] == 1 ? this._byAgence = true : this._byAgence = false;
    this._byAgence = obj["byAgence"];
    // print('the value of agence is ' + this._byAgence.toString());
    //this._byAgence = obj['byAgence'];
    this._Calculated_name = obj['Calculated_name'];
    this._capital = obj['capital'];
    this._codeCertificateRegistration = obj['codeCertificateRegistration'];
    this._codeLow = obj['codeLow'];
    this._confirmNewPassword = obj['confirmNewPassword'];
    this._Creation_place = obj['Creation_place'];
    this._currency = obj['currency'];
    this._Current_Id_role = obj['Current_Id_role'];
    this._date_Delivery_Certificate = obj['date_Delivery_Certificate'];
    this._dateEndContract = obj['dateEndContract'];
    this._dateLow = obj['dateLow'];
    this._dateRecruitment = obj['dateRecruitment'];
    this._entiteId_ = obj['entiteId_'];
    this._externalCode = obj['External_code'];
    this._is_doubtful = obj['is_doubtful'];
    this._isFromDevice = obj['isFromDevice'];
    this._logo = obj['logo'];
    this._max_Contract_in_Execution = obj['max_Contract_in_Execution'];
    this._maxBudgetReserve = obj['maxBudgetReserve'];
    this._maxContractApprovalReserve = obj['maxContractApprovalReserve'];
    this._Member_number = obj['Member_number'];
    this._member_number_flag = obj['member_number_flag'];
    this._newPassword = obj['newPassword'];
    this._No_MaxGuarantee = obj['No_MaxGuarantee'];
    this._number_order = obj['number_order'];
    this._numberFamily = obj['numberFamily'];
    this._numberFemaleMember = obj['numberFemaleMember'];
    this._numberMaleMember = obj['numberMaleMember'];
    this._numberNewCustomer = obj['numberNewCustomer'];
    this._old_customer_number = obj['old_customer_number'];
    this._oldPassword = obj['oldPassword'];
    this._question = obj['question'];
    this._reply = obj['reply'];
    this._Social_Guarantee = obj['Social_Guarantee'];
    this._Social_reason = obj['Social_reason'];
    this._synchDate_ = obj['synchDate_'];
    this._tax_code = obj['tax_code'];
    this._temporaryPassword = obj['temporaryPassword'];
    this._typeContrat = obj['typeContrat'];
    this._userId_ = obj['userId_'];
    this._dateSend = obj['dateSend'];
    this._isSend = obj['isSend'];
  }

// create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._synch = json['isSynchronized'];
    this._state = json['state_'];
    this._userId_ = json['userId_'];
    this._userType = json['typeActeurId'];
    this._sex = json['sexeId'];
    this._nationality = json['nationaliteId'];
    this._activity = json['activiteActeurId'];
    this._identityType = json['typeIdentiteId'];
    this._studyLevel = json['niveauEtudeId'];
    this._povertyDegree = json['degrePauvreteId'];
    this._profession = json['professionId'];
    this._occupation = json['typeOccupationId'];
    this._familySituation = json['situationFamilialeId'];
    this._familyResources = json['ressourcesFamilleId'];
    this._sectorId = json['secteurId'];
    this._fonctionUserId = json['fonctionUserId'];
    this._CategorySupplierId = json['categorieFournisseurId'];
    this._typeCompanyId = json['typeSocieteId'];
    this._typeAuthenticationUserId = json['typeAuthentificationUserId'];
    this._localityId = json['localiteIds'];
    this._idMobile = json['idMobile'];
    this._username = json['login'];
    this._password = json['password'];
    this._image = json['photo'];
    this._firstname = json['premierPrenom'];
    this._secondname = json['deuxiemePrenom'];
    this._thirdname = json['troisiemePrenom'];
    this._fourthname = json['quatriemePrenom'];
    this._name = json['nom'];
    this._arabicName = json['nomDL'];
    this._birthdate = json['dateNaissance'];
    this._birthplace = json['lieuNaissance'];
    this._arabicBirthplace = json['lieuNaissanceDL'];
    this._information = json['information'];
    this._bankaccount = json['compteBancaire'];
    this._legacy = json['patrimoine'];
    this._numberChildrenCharge = json['nombreEnfantsACharge'];
    this._numberChildrenSchoolers = json['nombreEnfantsScolarises'];
    this._spouseactivity = json['activiteConjoint'];
    this._identity = json['identite'];
    this._deliverydate = json['dateLivraison'];
    this._deliveryplace = json['lieuLivraison'];
    this._arabicDeliveryplace = json['lieuLivraisonDL'];
    this._dateEndValidity = json['dateFinValidite'];
    json['regionAdresse'] == null
        ? this._regionAddress = json['regionAdresse']
        : this._regionAddress = int.parse(json['regionAdresse']);
    // this._regionAddress = int.parse(json['regionAdresse']);
    json['provinceAdresse'] == null
        ? this._provinceAddress = json['provinceAdresse']
        : this._provinceAddress = int.parse(json['provinceAdresse']);
    //this._provinceAddress = int.parse(json['provinceAdresse']);
    json['localiteAdresse'] == null
        ? this._localityAddress = json['localiteAdresse']
        : this._localityAddress = int.parse(json['localiteAdresse']);
    //this._localityAddress = int.parse(json['localiteAdresse']);
    this._additionalAdresse = json['complementAdresse'];
    this._arabicAdditionalAdresse = json['complementDLAdresse'];
    this._mapsAddress = json['mapsCordsAdresse'];
    json['regionAdresseProffessionnelle'] == null
        ? this._regionBusinessAddress = json['regionAdresseProffessionnelle']
        : this._regionBusinessAddress =
            int.parse(json['regionAdresseProffessionnelle']);
    // this._regionBusinessAddress = int.parse(json['regionAdresseProffessionnelle']);
    json['provinceAdresseProffessionnelle'] == null
        ? this._provinceBusinessAddress =
            json['provinceAdresseProffessionnelle']
        : this._provinceBusinessAddress =
            int.parse(json['provinceAdresseProffessionnelle']);
    //this._provinceBusinessAddress = int.parse(json['provinceAdresseProffessionnelle']);
    json['localiteAdresseProffessionnelle'] == null
        ? this._localityBusinessAddress =
            json['localiteAdresseProffessionnelle']
        : this._localityBusinessAddress =
            int.parse(json['localiteAdresseProffessionnelle']);
    //this._localityBusinessAddress = int.parse(json['localiteAdresseProffessionnelle']);
    this._additionalBusinessAddress = json['complementAdresseProffessionnelle'];
    this._arabicAdditionalBusinessAddress = json['complementDLAdresseProffessionnelle'];
    this._mapsCordsBusinessAddress = json['mapsCordsAdresseProffessionnelle'];
    this._telephone = json['telephone'];
    this._telephoneTwo = json['telephoneDeux'];
    this._email = json['email'];
    this._fax = json['fax'];
    this._monthly_income = json['revenuMensuel'];
    this._AverageIndividualExpensePerDay = json['moyenneDepensesIndviduParJour'];
    this._officeCredit = json['creditBureau'];
    this._blackList = json['blackList'];
    this._blackListDate = json['blackListDate'];
    this._ExternalFunding = json['financementExternes'];
    this._authorizationCode = json['authorizationCode'];
    this._code = json['code'];
    this._addDepot = json['ajouterDepot'];
    this._amountDisbursement = json['montantDecaissement'];
    this._AmountMax_Guarantee = json['montantMaxGarantie'];
    this._byAgence = json['byAgence'];
    this._Calculated_name = json['nomCalcule'];
    this._capital = json['capital'];
    this._codeCertificateRegistration = json['codeCertificatInscription'];
    this._codeLow = json['codeLoi'];
    this._confirmNewPassword = json['confirmNewPassword'];
    this._Creation_place = json['lieuCreation'];
    this._currency = json['devise'];
    this._Current_Id_role = json['roleCourantId'];
    this._date_Delivery_Certificate = json['dateLivraisonCertificat'];
    this._dateEndContract = json['dateFinContrat'];
    this._dateLow = json['dateLoi'];
    this._dateRecruitment = json['dateRecrutement'];
    this._entiteId_ = json['entiteId_'];
    this._externalCode = json['codeExterne'];
    this._is_doubtful = json['isDouteux'];
    this._isFromDevice = json['isFromDevice'];
    this._logo = json['logo'];
    this._max_Contract_in_Execution = json['maxContratEnExecution'];
    this._maxBudgetReserve = json['maxBudgetReserve'];
    this._maxContractApprovalReserve = json['maxContratApprobationReserve'];
    this._Member_number = json['nombreMembre'].toString();
    this._member_number_flag = json['flagNombreMembre'];
    this._newPassword = json['newPassword'];
    this._No_MaxGuarantee = json['nbreMaxGarantie'];
    this._number_order = json['numeroOrdre'];
    this._numberFamily = json['nombreFamille'].toString();
    this._numberFemaleMember = json['nombreMembreFeminin'].toString();
    this._numberMaleMember = json['nombreMembreMasculin'].toString();
    this._numberNewCustomer = json['nombreNouveauClient'].toString();
    this._old_customer_number = json['nombreAncienClient'];
    this._oldPassword = json['oldPassword'];
    this._question = json['question'];
    this._reply = json['reponse'];
    this._Social_Guarantee = json['couvertureSociale'];
    this._Social_reason = json['raisonSocial'];
    this._synchDate_ = json['synchronizationDate_'];
    this._tax_code = json['codeFiscal'];
    this._temporaryPassword = json['temporaryPassword'];
    this._typeContrat = json['typeContrat'];
    this._userId_ = json['userId_'];
    this._dateSend = json['dateSend'];
    this._isSend = json['isSend'];
  }

/*
  Map<String, dynamic> toJson() {
    var json = new Map<String, dynamic>();

    json['id'] = _id;
    json['state_'] = _state;
    json['userId_'] = _userId_;
    json['categorieFournisseurId'] = _CategorySupplierId;
    json['typeSocieteId'] = _typeCompanyId;
    json['typeAuthentificationUserId'] = _typeAuthenticationUserId;
    //json['idMobile'] = _idMobile;
    json['login'] = _username;
    json['password'] = _password;
    json['information'] = _information;
    json['compteBancaire'] = _bankaccount;
    json['patrimoine'] = _legacy;
    json['nombreEnfantsACharge'] = _numberChildrenCharge;
    json['nombreEnfantsScolarises'] = _numberChildrenSchoolers;
    json['activiteConjoint'] = _spouseactivity;
    json['dateLivraison'] = _deliverydate;
    json['lieuLivraison'] = _deliveryplace;
    json['lieuLivraisonDL'] = _arabicDeliveryplace;
    json['revenuMensuel'] = _monthly_income;
    json['moyenneDepensesIndviduParJour'] = _AverageIndividualExpensePerDay;
    json['creditBureau'] = _officeCredit;
    json['blackList'] = _blackList;
    json['blackListDate'] = _blackListDate;
    json['financementExternes'] = _ExternalFunding;
    json['ajouterDepot'] = _addDepot;
    json['montantDecaissement'] = _amountDisbursement;
    json['montantMaxGarantie'] = _AmountMax_Guarantee;
    //json['byAgence'] = _byAgence;
    json['capital'] = _capital;
    json['codeCertificatInscription'] = _codeCertificateRegistration;
    json['codeLoi'] = _codeLow;
    json['confirmNewPassword'] = _confirmNewPassword;
    json['devise'] = _currency;
    json['roleCourantId'] = _Current_Id_role;
    json['dateLivraisonCertificat'] = _date_Delivery_Certificate;
    json['dateFinContrat'] = _dateEndContract;
    json['dateLoi'] = _dateLow;
    json['dateRecrutement'] = _dateRecruitment;
    json['entiteId_'] = _entiteId_;
    json['isDouteux'] = _is_doubtful;
    json['logo'] = _logo;
    json['maxContratEnExecution'] = _max_Contract_in_Execution;
    json['maxBudgetReserve'] = _maxBudgetReserve;
    json['maxContratApprobationReserve'] = _maxContractApprovalReserve;
    json['flagNombreMembre'] = _member_number_flag;
    json['newPassword'] = _newPassword;
    json['nbreMaxGarantie'] = _No_MaxGuarantee;
    json['numeroOrdre'] = _number_order;
    _numberNewCustomer == null ? json['nombreNouveauClient'] = _numberNewCustomer
    : json['nombreNouveauClient'] = int.parse(_numberNewCustomer);
    json['nombreAncienClient'] = _old_customer_number;
    json['oldPassword'] = _oldPassword;
    json['question'] = _question;
    json['reponse'] = _reply;
    json['couvertureSociale'] = _Social_Guarantee;
    json['raisonSocial'] = _Social_reason;
    json['codeFiscal'] = _tax_code;
    json['temporaryPassword'] = _temporaryPassword;
    json['typeContrat'] = _typeContrat;
   // json['dateSend'] = _dateSend;

    return json;
  }
*/

  Map<String, dynamic> toJson() {
    var json = new Map<String, dynamic>();

    json['code'] = _code;
    json['nom'] = _name;
    json['premierPrenom'] = _firstname;
    json['deuxiemePrenom'] = _secondname;
    json['troisiemePrenom'] = _thirdname;
    json['quatriemePrenom'] = _fourthname;
    json['identite'] = _identity;
    json['dateCreation'] = _deliverydate;
    json['lieuCreation'] = _deliveryplace;
    _Member_number == null ? json['nombreMembre'] = _Member_number
        : json['nombreMembre'] = int.parse(_Member_number);
    json['regionAdresse'] = _regionAddress;
    json['provinceAdresse'] = _provinceAddress;
    json['localiteAdresse'] = _localityAddress;
    json['complementAdresse'] = _additionalAdresse;
    json['complementDLAdresse'] = _arabicAdditionalAdresse;
    json['mapsCordsAdresse'] = _mapsAddress;
    json['telephone'] = _telephone;
    json['telephoneDeux'] = _telephoneTwo;
    json['email'] = _email;
    json['fax'] = _fax;
    json['codeExterne'] = _externalCode;
    json['dateNaissance'] = _birthdate;
    json['lieuNaissance'] = _birthplace;
    json['roleCourantId'] = _Current_Id_role;
    json['dateFinValidite'] = _dateEndValidity;
    json['photo'] = _image;
    _numberFamily == null ? json['nombreFamille'] = _numberFamily
        : json['nombreFamille'] = int.parse(_numberFamily);
    _numberFemaleMember == null ? json['nombreMembreFeminin'] = _numberFemaleMember
        : json['nombreMembreFeminin'] = int.parse(_numberFemaleMember);
    _numberMaleMember == null ? json['nombreMembreMasculin'] = _numberMaleMember
        : json['nombreMembreMasculin'] = int.parse(_numberMaleMember);
    json['nomCalcule'] = _Calculated_name;
    json['nomDL'] = _arabicName;
    json['regionAdresseProffessionnelle'] = _regionBusinessAddress;
    json['provinceAdresseProffessionnelle'] = _provinceBusinessAddress;
    json['localiteAdresseProffessionnelle'] = _localityBusinessAddress;
    json['complementAdresseProffessionnelle'] = _additionalBusinessAddress;
    json['complementDLAdresseProffessionnelle'] = _arabicAdditionalBusinessAddress;
    json['mapsCordsAdresseProffessionnelle'] = _mapsCordsBusinessAddress;
    json['lieuNaissanceDL'] = _arabicBirthplace;
    json['typeActeurId'] = _userType;
    json['typeIdentiteId'] = _identityType;
    json['secteurId'] = _sectorId;
    json['sexeId'] = _sex;
    json['niveauEtudeId'] = _studyLevel;
    json['professionId'] = _profession;
    json['fonctionUserId'] = _fonctionUserId;
    json['nationaliteId'] = _nationality;
    json['typeOccupationId'] = _occupation;
    json['degrePauvreteId'] = _povertyDegree;
    json['situationFamilialeId'] = _familySituation;
    json['ressourcesFamilleId'] = _familyResources;
    json['activiteActeurId'] = _activity;
    json['localiteIds'] = _localityId;
    json['authorizationCode'] = _authorizationCode;
    json['synchronizationDate_'] = _synchDate_;
    json['isSynchronized'] = _synch;
    _isSend == null ? json['isFromDevice'] = _isSend
        : json['isFromDevice'] = int.parse(_isSend);

    return json;
  }
}
