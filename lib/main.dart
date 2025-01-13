import 'package:d_report/src/core/config/styles/themes.dart';
import 'package:d_report/src/feature/auth/presentation/pages/login_page.dart';
import 'package:d_report/src/feature/auth_register/presentation/page/register_page.dart';
import 'package:d_report/src/feature/end_case/presentation/page/end_case_page.dart';
import 'package:d_report/src/feature/find_patient/presentation/pages/find_patient_page.dart';
import 'package:d_report/src/feature/main_page/presentation/pages/main_page.dart';
import 'package:d_report/src/feature/main_page_find/presentation/page/main_page_find.dart';
import 'package:d_report/src/feature/new_case/presentation/pages/new_case_page.dart';
import 'package:d_report/src/feature/new_follow/presentation/pages/new_follow_case_page.dart';
import 'package:d_report/src/feature/new_patient/presentation/pages/new_patient_page.dart';
import 'package:d_report/src/feature/not_found/presentation/pages/not-found_page.dart';
import 'package:d_report/src/feature/patient_case_edit_pat_guardian/presentation/pages/patient_case_edit_case_page.dart';
import 'package:d_report/src/feature/patient_case_edit_selector/presentation/pages/patient_case_selector_page.dart';
import 'package:d_report/src/feature/patient_case_follow_details/presentation/pages/patient_case_follow_details_page.dart';
import 'package:d_report/src/feature/patients_details/presentation/pages/patient-details_page.dart';
import 'package:d_report/src/feature/profile_user/presentation/pages/edit_profile_page.dart';
import 'package:d_report/src/feature/profile_user/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Flutter D Project APP',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // Edit for change theme color
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth/login/': (context) => const LoginPage(),
        '/auth/register/': (context) => const RegisterPage(),
        '/main/patients/': (context) => const MainPage(),
        '/main/patients/find/': (context) => const MainPageFind(),
        '/main/patients/details/': (context) => const PatientDetailsPage(),
        '/main/patients/details/follow-case': (context) => const PatientFollowCaseDetailsPage(),
        '/main/patients/details/create-follow-case': (context) => const NewFollowCasePage(),
        '/main/patients/details/edit-case': (context) => const PatientEditPageSelector(),
        '/main/patients/details/edit-case/patient': (context) => const PatientEditPageSelector(),
        '/main/patients/details/edit-case/patient-guardian': (context) => const PatientEditPageSelector(),
        '/main/patients/details/edit-case/case': (context) => const EditCaseCasePage(),
        '/main/patients/details/end-case': (context) => const EndCasePage(),
        '/main/profile/': (context) => const ProfilePage(),
        '/main/profile/edit-row': (context) => const EditProfilePage(dataField: 'pepe',), // TODO CHANGE
        '/main/config/': (context) => const NotFoundPage(),
        '/main/new-case/new-patient': (context) => const NewPatientPage(),
        '/main/new-case/find-patient': (context) => const FindPatientPage(),
        '/main/new-case/add-case': (context) => const NewCasePage(),
      },
      initialRoute: '/auth/login/',
      onUnknownRoute: (RouteSettings setting) {
        //settings: setting;
          return MaterialPageRoute(
        builder: (context) => const NotFoundPage()
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale ('es', 'ES'),
      ],

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
