import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:flutter/material.dart';

import '../models/my_case_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class MyCasesLocalDataSources{
  Future<List<MyCasesModel>> searchCase(String patName);
}

/*class HiveMyCasesDataSourceImpl implements MyCasesLocalDataSources {

  HiveMyCasesDataSourceImpl() {
    Hive.initFlutter();
  }


  @override
  Future<List<MyCasesModel>> saveCases(Page<CaseSimple> cases) async {

    try {
      Box<dynamic> box = await Hive.openBox("cases");
      for(var myCases in cases) {

      }
      box.put()

    } catch (e) {

    }
  }

}*/