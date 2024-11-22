
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../widgets/dynamic_edit_field.dart';
import '../widgets/firstname_field.dart';
import '../widgets/genre-user_field.dart';

class EditProfilePage extends StatelessWidget {

  //final String namePatient;

  const EditProfilePage({super.key, required this.dataField});

  final String dataField;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;

    final size = MediaQuery.of(context).size;

    final _formatKey = GlobalKey<FormState>();

    return Scaffold(

      appBar: AppBar(
        title: Text(
            edit + space + dataField,
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
                      child: Text('fecha'
                      ),
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