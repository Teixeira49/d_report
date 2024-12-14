import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/end_case/data/repositories/end_case_repository.dart';
import 'package:d_report/src/feature/end_case/domain/entities/end_case_dto.dart';
import 'end_case_send_state.dart';


class EndAssignCubit extends Cubit<SendEndCaseState>{

  EndAssignCubit({required EndCaseRepositoryImpl endCaseRepositoryImpl}) : _endCaseRepositoryImpl = endCaseRepositoryImpl, super(SendEndCaseInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final EndCaseRepositoryImpl _endCaseRepositoryImpl;

  Future<void> sendEndCaseData(int casId, int patId, String endReason, String endDiagnosis, String accessToken) async {

    try{

      emit(SendEndCaseLoading());

      final data = await _endCaseRepositoryImpl.endSelectedCase(EndCaseDTO(encPatId: patId, encCasId: casId, encEndReason: endReason), accessToken);

      data.fold(
              (l) => emit(SendEndCaseFail(errorSMS: l.message)),
              (r) => emit(SendEndCaseLoaded(caseReport: r))
      );

    }catch(e){
      emit(SendEndCaseFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }

  }
}