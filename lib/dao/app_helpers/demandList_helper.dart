import 'dart:async';

import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/demandList.dart';

class DemandListHelper {
  DatabaseHelper con = new DatabaseHelper();


  Future<List<Map<String, dynamic>>> getDemandMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT TB_ACTOR.id as idBeneficiary, TB_ACTOR.name as Name, TB_FINANCING_REQUEST.id as idDemand, TB_FINANCING_REQUEST.designation, TB_FINANCING_REQUEST.natureRequestId, TB_FINANCING_REQUEST.sectorId, TB_FINANCING_REQUEST.natureProjectId, TB_FINANCING_REQUEST.synch, TB_FINANCING_REQUEST.isSend FROM TB_ACTOR left outer join  TB_FINANCING_REQUEST ON TB_FINANCING_REQUEST.beneficiaryId = TB_ACTOR.id WHERE TB_FINANCING_REQUEST.beneficiaryId = TB_ACTOR.id ");
    return result;
  }

  Future<List<DeList>> getDemandList() async {

    var demandMapList = await getDemandMapList();
    int count = demandMapList.length;

    // ignore: deprecated_member_use
    List<DeList> demandList = List<DeList>();

    for (int i = 0; i < count; i++) {
      demandList.add(DeList.fromMapObject(demandMapList[i]));
    }

    return demandList;
  }

}
