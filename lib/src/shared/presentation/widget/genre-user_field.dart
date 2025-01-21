import 'package:d_report/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class TypeGenreDropdownField extends StatefulWidget {

  const TypeGenreDropdownField({super.key, required this.controllerData});

  final ValueNotifier<String?> controllerData;

  @override
  MyTypeGenreDropdownField createState() => MyTypeGenreDropdownField();

} class MyTypeGenreDropdownField extends State<TypeGenreDropdownField> {

  IconData defaultIcon = MyFlutterApp.genderless;
  IconData iconSelector(String? value) {
    if (value == "Male") {
      return Icons.male_outlined;
    } else if (value == "Female") {
      return Icons.female_outlined;
    } else {
      return MyFlutterApp.transgender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField(
          onChanged: (String? newValue) {
            widget.controllerData.value = newValue!;
            setState(() {
              defaultIcon = iconSelector(widget.controllerData.value);
            });
          },
          value: widget.controllerData.value,
          style: Theme.of(context).textTheme.labelLarge,
          dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: Theme.of(context).inputDecorationTheme.filled,
            border: Theme.of(context).inputDecorationTheme.border,
            suffixIcon: Icon(
              defaultIcon,
              color: Theme.of(context).iconTheme.color,
            ),
            labelText: genre,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintGenre,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle
          ),
          items: genreType.map((users){
            return DropdownMenuItem(
                alignment: Alignment.centerLeft,
                value: users,
                child: Text(
                  users,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                )
            );
          }).toList(),
          //onSaved: (String? value) {},
          isDense: true,
          isExpanded: true,
        ),
    );
   }
}