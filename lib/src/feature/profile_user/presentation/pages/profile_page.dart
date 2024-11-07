import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/drawer.dart';
import '../widgets/custom_card_profile.dart';
import '../widgets/firstname_field.dart';

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

    var userName = "Pepe loco";
    var accountEmail = "Pepeloco@gmail.com";
    var accountName = "Doctor"; // TODO take name for back
    var img = "";
    final size = MediaQuery.of(context).size;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final _formatKey = GlobalKey<FormState>();

    return Scaffold(

      key: scaffoldKey,

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      drawer: NavigatorDrawer(user: user),

      body: Center(
        child: CustomScrollView(
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
                      //padding: EdgeInsets.symmetric(
                      //  horizontal: size.width * 0.075,
                      //  vertical: size.height * 0.025,
                      //),
                      child: CustomCardProfileRow(defaultKey: "Name", defaultValue: "pepe",)
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(
                    //  horizontal: size.width * 0.075,
                    //  vertical: size.height * 0.025,
                    //),
                      child: CustomCardProfileRow(defaultKey: "Apellido", defaultValue: "Gonzales",)
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(
                    //  horizontal: size.width * 0.075,
                    //  vertical: size.height * 0.025,
                    //),
                      child: CustomCardProfileRow(defaultKey: "Cedula", defaultValue: "123124",)
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(
                    //  horizontal: size.width * 0.075,
                    //  vertical: size.height * 0.025,
                    //),
                      child: CustomCardProfileRow(defaultKey: "Cumpleaños", defaultValue: "25/20/1980",)
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(
                    //  horizontal: size.width * 0.075,
                    //  vertical: size.height * 0.025,
                    //),
                      child: CustomCardProfileRow(defaultKey: "Genero", defaultValue: "Hombre",)
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(
                    //  horizontal: size.width * 0.075,
                    //  vertical: size.height * 0.025,
                    //),
                      child: CustomCardProfileRow(defaultKey: "Rango", defaultValue: "Doctor",)
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(
                    //  horizontal: size.width * 0.075,
                    //  vertical: size.height * 0.025,
                    //),
                      child: CustomCardProfileRow(defaultKey: "Especialidad", defaultValue: "Bacteriologo",)
                  ),
                  Container(
                      //padding: EdgeInsets.symmetric(
                        //  horizontal: size.width * 0.075,
                      //  vertical: size.height * 0.025,
                      //),
                      child: CustomCardProfileRow(defaultKey: "ID Usuario", defaultValue: "12412",)
                  ),
                  MaterialButton(
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
                      Navigator.of(context).pushNamed('/main/profile/edit-row');
                    },
                  )
                ]
              ),
            )
          ],

            )
        ),
    );
  }
}