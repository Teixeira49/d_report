import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/drawer.dart';
import '../../domain/entities/doctor.dart';
import '../widgets/custom_card_profile.dart';
import '../widgets/data_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  MyProfilePageState createState() => MyProfilePageState();

}

class MyProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context){

    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    Doctor doctor = Doctor(id: 1, firstName: "pepe",
        lastName: "Gonzales", dni: 123124,
        birthday: "25-10-1980", genre: "Male", range: "Doctor",
        speciality: "Bacteriologo");

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final _formatKey = GlobalKey<FormState>();

    final size = MediaQuery.of(context).size;

    return Scaffold(

      key: scaffoldKey,

      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text("Perfil  "),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                print(user.userName);
                print(user.userRoleUid);
                print(user.userEmail);
                Navigator.of(context).pushNamed('/main/profile/edit-row', arguments: {
                  'userData': argument["userData"],
                  'doctorData': doctor,
                });
              },)
          ]
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: true,
      ),

      drawer: NavigatorDrawer(user: user, authUser: authUser,),

      body: Center(
        child: ListView(
          children: [
            Container(
              height: 225,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                      children: [
                        CircleAvatar(
                          radius: 65.0,
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ]
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    '${user.userRoleUid}. ${user.userName}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '${user.userEmail}',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            CustomCardProfileRow(defaultKey: "Nombre", defaultValue: "${doctor.firstName} ${doctor.lastName}",),
            CustomCardProfileRow(defaultKey: "Cedula", defaultValue: "123124",),
            CustomCardProfileRow(defaultKey: "Cumpleaños", defaultValue: "25/20/1980",),
            CustomCardProfileRow(defaultKey: "Genero", defaultValue: "Hombre",),
            CustomCardProfileRow(defaultKey: "Especialidad", defaultValue: "Doctor - Bacteriologo",),
            CustomCardProfileRow(defaultKey: "ID Usuario", defaultValue: "12412",),
          ],
        )
        ),
    );
  }
}