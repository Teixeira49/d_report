import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/case_repository.dart';
import 'package:d_report/src/feature/patients_details/presentation/cubit/end_assign/end_assign_state.dart';


class EndAssignCubit extends Cubit<EndAssignState>{

  EndAssignCubit({required PatientRepositoryImpl patientRepositoryImpl}) : _patientRepositoryImpl = patientRepositoryImpl, super(EndAssignInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final PatientRepositoryImpl _patientRepositoryImpl;

  Future<void> fetchEndAssignDetails(int casId, int docId, String accessToken) async {

    try{

      emit(EndAssignLoading());

      final data = await _patientRepositoryImpl.endAssignment(casId, docId, accessToken);

      data.fold(
              (l) => emit(EndAssignFail(errorSMS: l.message)),
              (r) => emit(EndAssignLoaded(endAssign: r))
      );

    }catch(e){
      emit(EndAssignFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }

  }
}