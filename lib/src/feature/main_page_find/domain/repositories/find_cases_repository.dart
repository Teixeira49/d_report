import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/case_simple.dart';

abstract class FindCasesRepository {

  Future<Either<Failure, List<CaseSimple>>> searchCasesByKey(String query, int searchKey, String accessToken);

  Future<Either<Failure, bool>> saveLocalMyCase(Page<CaseSimple> caseSimple);

  Future<Either<Failure, List<CaseSimple>>> getSearchInMyCases(String patName);

}

