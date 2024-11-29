
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../widgets/date_field.dart';
import '../widgets/dynamic_edit_field.dart';
import '../widgets/firstname_field.dart';
import '../widgets/genre-user_field.dart';

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

    final size = MediaQuery.of(context).size;

    final formatKey = GlobalKey<FormState>();

    Future<void> selectDate (BuildContext context) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now()
      );

      print(picked);
      print("PEPE");
      if (picked != null && picked != selectedDate) {
        print('pepe');
        setState(() {
          selectedDate = picked;
          dateController.text = selectedDate.toString().split(" ")[0];
        });
      }
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(
            edit + space + widget.dataField,
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
                    backgroundColor: Theme.of(context).iconTheme.color,
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
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.025,
                      ),
                      child: const FirstNameTextField(defaultName: 'Pepe')
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.025,
                      ),
                      child: const FirstNameTextField(defaultName: 'Gonzales')
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.025,
                      ),
                      child: const FirstNameTextField(defaultName: '28432830')
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.025,
                      ),
                      child: TextField(
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
                        vertical: size.height * 0.025,
                      ),
                      child: TypeGenreDropdownField()
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.025,
                      ),
                      child: const FirstNameTextField(defaultName: 'Especialidad')
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.025,
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