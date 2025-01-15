import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/remote/case_edit_request_remote_data_source.dart';
import '../../data/repositories/case_edit_repository.dart';
import '../../domain/use_cases/post_case_data.dart';
import '../cubit/case_editor/case_editor_cubit.dart';

class PatientDetailsEditPage extends StatelessWidget {
  PatientDetailsEditPage({super.key});

  final PageController _controller = PageController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayDateController = TextEditingController();
  final TextEditingController _birthdayPlaceController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final ValueNotifier<String?> _genderController = ValueNotifier<String?>(null);
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final ValueNotifier<String?> _bloodTypeController = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final CaseEditRequestRemoteDataSourceImpl caseEditRequestRemoteDataSource =
        CaseEditRequestRemoteDataSourceImpl();
    final CaseEditRepositoryImpl caseEditRepository =
        CaseEditRepositoryImpl(caseEditRequestRemoteDataSource);
    final PostCaseDateUseCase postCaseDateUseCase =
        PostCaseDateUseCase(caseEditRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CaseEditorCubit(postCaseDateUseCase))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ejemplo'),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
                Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.25,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.25,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(child: Container(padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.020,
                            ), child: Text("editar"),))
                          ],
                        ),
                      ),
                    ),
                ),),
            //Text('No se que poner aqui')
          ],
        ),
      ),
    );
  }
}
