import 'package:d_report/src/feature/main_page_find/domain/entities/search_filter.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import 'custom_status_selector.dart';


Future<void> searchFilterWindow(BuildContext context, SearchFilter searchFilter) {

  ValueNotifier<String?> controllerGenderDropDown = ValueNotifier(null);
  ValueNotifier<String?> controllerStatusDropDown = ValueNotifier(null);
  ValueNotifier<String?> controllerEndCasDropDown = ValueNotifier(null);

  return showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          AlertDialog(
            title: Text('Mas Filtros'),
            backgroundColor:
            Theme
                .of(dialogContext)
                .scaffoldBackgroundColor,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Genero'),
                    Spacer(),
                    Expanded(child: CustomStatusSelector(controllerDataDropDown: controllerGenderDropDown, options: genreTypeFull,)
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estatus'),
                    Spacer(),
                    Expanded(child: CustomStatusSelector(controllerDataDropDown: controllerStatusDropDown, options: caseStatusType,))
                  ],
                ),
                Divider(),
                Visibility(
                  visible: controllerStatusDropDown.value == 'Finalizado' || controllerStatusDropDown.value == 'Todos',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estado del Caso'),
                        Spacer(),
                        Expanded(child: CustomStatusSelector(controllerDataDropDown: controllerEndCasDropDown, options: endCaseTypeFull,))
                      ],
                    ),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                      color: Theme
                          .of(dialogContext)
                          .colorScheme
                          .secondary),
                ),
              ),
              TextButton(
                  onPressed: () {
                    searchFilter.setParameters(controllerGenderDropDown.value, controllerEndCasDropDown.value, controllerStatusDropDown.value);
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: const Text('Aplicar'))
            ],
          ),
    );
}