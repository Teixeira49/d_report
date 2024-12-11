
import 'package:d_report/src/feature/profile_user/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/domain/entities/user.dart';
import '../widgets/date_field.dart';
import '../widgets/dynamic_edit_field.dart';
import '../widgets/data_textfield.dart';
import '../../../../shared/presentation/widget/genre-user_field.dart';

class EditProfilePage extends StatefulWidget {

  //final String namePatient;

  const EditProfilePage({super.key, required this.dataField});

  final String dataField;

  @override
  MyEditProfilePageState createState() => MyEditProfilePageState();
}

  class MyEditProfilePageState extends State<EditProfilePage> {

    DateTime selectedDate = DateTime.now();

    TextEditingController dateController = TextEditingController();

    @override
    Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;
      final argument = ModalRoute.of(context)!.settings.arguments as Map;

      User user = argument["userData"];
      Doctor doctor = argument["doctorData"];


      final size = MediaQuery.of(context).size;

      final formatKey = GlobalKey<FormState>();

      Future<void> selectDate (BuildContext context) async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now()
      );

      if (picked != null && picked != selectedDate) {

        setState(() {
          selectedDate = picked;
          dateController.text = selectedDate.toString().split(" ")[0];
        });
      }
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(
            edit,
          style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),

          SliverList(
            delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: DataTextField(defaultName: doctor.firstName, contextRow: "Nombre",)
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: DataTextField(defaultName: doctor.lastName, contextRow: "Apellido",)
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: DataTextField(defaultName: doctor.dni.toString(), contextRow: "Cedula",)
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: TextFormField(
                        //initialValue: doctor.birthday,
                        controller: dateController,
                        readOnly: true,
                        //decoration: InputDecoration(
                        //  labelText: dateController.text == '' ? 'Pepe' : dateController.text
                        //),
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                          filled: Theme.of(context).inputDecorationTheme.filled,
                          border: Theme.of(context).inputDecorationTheme.border,
                          suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).iconTheme.color
                          ),
                          labelText: "Cumpleaños",
                          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                          hintText: "Cumpleaños no seleccionado",
                          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                        ),
                        style: Theme.of(context).inputDecorationTheme.labelStyle,
                        onTap: () => selectDate(context),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: Container()//TypeGenreDropdownField(controllerData: 'a',)
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: const DataTextField(defaultName: 'Bacteriologo', contextRow: 'Especialidad')
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: MaterialButton(
                          color: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          focusColor: Theme.of(context).colorScheme.inversePrimary,
                          child: const Text(
                              "Continuar",
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          onPressed: () {
                            print(selectedDate);
                            Navigator.of(context).pop();
                          },
                    )
                  ),
                ]
            ),
          )
        ],

      )

      );
  }
}