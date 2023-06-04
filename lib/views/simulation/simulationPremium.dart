import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';

class CalculatePremium extends StatefulWidget {
  @override
  _CalculatePremiumState createState() => _CalculatePremiumState();
}

class _CalculatePremiumState extends State<CalculatePremium> {
  var _formKey = GlobalKey<FormState>();

  int _investmentAmount;
  int _contributionAmount;
  int _fundingAmount;
  int _duration;
  int _gracePeriod;
  int _profitRate;
  double _profitMargin;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController investmentAmountController = TextEditingController();
  TextEditingController contributionAmountController = TextEditingController();
  TextEditingController fundingAmountController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController gracePeriodController = TextEditingController();
  TextEditingController profitRateController = TextEditingController();
  TextEditingController periodicReimbursementController =
  TextEditingController();
  TextEditingController profitMarginController = TextEditingController();
  TextEditingController totalSellingAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslated('simulator')),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  //First Element
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: investmentAmountController,
                      style: textStyle,
                      textAlign: TextAlign.left,
                      onChanged: (String value) {
                        try {
                          _investmentAmount =
                              int.parse(investmentAmountController.text);
                        } catch (exception) {}
                      },
                      decoration: InputDecoration(
                          prefixIcon: new Image.asset(AssetsPath.investment),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('investmentAmount'),
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))
                      ),
                    ),
                  ),

                  // Second Element
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: contributionAmountController,
                      style: textStyle,
                      textAlign: TextAlign.left,
                      onChanged: (String value) {
                        debugPrint('Something changed in Amount Text Field');
                        try {
                          _contributionAmount =
                              int.parse(contributionAmountController.text);
                        } catch (exception) {}
                      },
                      decoration: InputDecoration(
                          prefixIcon:
                          new Image.asset(AssetsPath.contribution),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('contributionAmount'),
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // Third Element
                  ListTile(
                    title: TextFormField(
                      readOnly: true,
                      controller: fundingAmountController,
                      style: textStyle,
                      textAlign: TextAlign.left,
                      onTap: () {
                        calculateFundingAmount();
                      },
                      decoration: InputDecoration(
                          prefixIcon: new Image.asset(AssetsPath.funding),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('fundingAmount'),
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // Fourth Element
                  ListTile(
                    title: TextFormField(
                      //readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: durationController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'required fields';
                        }
                        return null;
                      },
                      style: textStyle,
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                        if (value.isNotEmpty) {
                          _duration = int.parse(durationController.text);
                        } else {
                          profitMarginController.clear();
                          periodicReimbursementController.clear();
                          totalSellingAmountController.clear();
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: new Image.asset(AssetsPath.duration),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('duration'),
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // Fifth Element
                  ListTile(
                    title: TextFormField(
                      //readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: gracePeriodController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'required fields';
                        }
                        return null;
                      },
                      style: textStyle,
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                        if (value.isNotEmpty) {
                          _gracePeriod = int.parse(gracePeriodController.text);
                        } else {
                          profitMarginController.clear();
                          periodicReimbursementController.clear();
                          totalSellingAmountController.clear();
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: new Image.asset(AssetsPath.period),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('gracePeriod'),
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // sixth Element
                  ListTile(
                    title: TextFormField(
                      //readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: profitRateController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'required fields';
                        }
                        return null;
                      },
                      style: textStyle,
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                        if (value.isNotEmpty) {
                          _profitRate = int.parse(profitRateController.text);
                        } else {
                          profitMarginController.clear();
                          periodicReimbursementController.clear();
                          totalSellingAmountController.clear();
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: new Image.asset(AssetsPath.rate),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('profitRate'),
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // seventh Element
                  ListTile(
                    title: TextFormField(
                      readOnly: true,
                      enabled: false,
                      controller: profitMarginController,
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.margin,
                              size: 32.0, color: Colors.green),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('profitMargin'),
                          labelStyle:
                          TextStyle(fontSize: 15, color: Colors.green),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // 8 Element
                  ListTile(
                    title: TextFormField(
                      readOnly: true,
                      enabled: false,
                      controller: periodicReimbursementController,
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.payment,
                            size: 32.0,
                            color: Colors.green,
                          ),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('periodicReimbursement'),
                          labelStyle:
                          TextStyle(fontSize: 15, color: Colors.green),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  // 9 Element
                  ListTile(
                    title: TextFormField(
                      readOnly: true,
                      enabled: false,
                      controller: totalSellingAmountController,
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        debugPrint(
                            'Something changed in Description Text Field');
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.monetization_on,
                              size: 32.0, color: Colors.green),
                          labelText: AppLocalizations.of(context)
                              .getTranslated('totalSellingAmount'),
                          labelStyle:
                          TextStyle(fontSize: 15, color: Colors.green),
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),

                  ListTile(
                    title: Container(
                        height: 70.0,
                        margin: EdgeInsets.all(0.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, right: 5.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (gracePeriodController
                                          .text.isNotEmpty &&
                                          durationController.text.isNotEmpty &&
                                          profitRateController
                                              .text.isNotEmpty) {
                                        // if (_formKey.currentState.validate()) {
                                        _fundingAmount = int.parse(
                                            fundingAmountController.text);
                                        profitMarginController.text =
                                            (((_profitRate / 100) / 12) *
                                                _fundingAmount *
                                                _duration)
                                                .toStringAsFixed(2);
                                        _profitMargin = double.parse(
                                            profitMarginController.text);
                                        calculation();
                                      } else if (durationController
                                          .text.isEmpty ||
                                          gracePeriodController.text.isEmpty ||
                                          profitRateController.text.isEmpty) {
                                        profitMarginController.clear();
                                        periodicReimbursementController.clear();
                                        totalSellingAmountController.clear();
                                      }
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff374ABE),
                                            Color(0xff64B6FF)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 250.0, minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .getTranslated("simulation"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, right: 5.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      clearForm();
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff374ABE),
                                            Color(0xff64B6FF)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 250.0, minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .getTranslated("reset"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ))),
    );
  }

  void calculateFundingAmount() {
    if (_investmentAmount != null &&
        _contributionAmount != null &&
        _investmentAmount >= _contributionAmount) {
      setState(() {
        fundingAmountController.text =
            (_investmentAmount - _contributionAmount).toString();
      });
    } else {}
  }

  void calculation() {
    periodicReimbursementController.text =
        ((_fundingAmount + _profitMargin) / (_duration - _gracePeriod))
            .toStringAsFixed(2);
    totalSellingAmountController.text =
        (_fundingAmount + _profitMargin).toStringAsFixed(2);
  }

  void clearForm() {
    investmentAmountController.clear();
    contributionAmountController.clear();
    fundingAmountController.clear();
    durationController.clear();
    gracePeriodController.clear();
    profitRateController.clear();
    profitMarginController.clear();
    periodicReimbursementController.clear();
    totalSellingAmountController.clear();
  }
}


