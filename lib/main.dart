import 'package:d_report/src/core/config/theme/themes.dart';
import 'package:d_report/src/feature/auth/presentation/pages/login_page.dart';
import 'package:d_report/src/feature/auth/presentation/pages/register_page.dart';
import 'package:d_report/src/feature/main_page/presentation/pages/main_page.dart';
import 'package:d_report/src/feature/not_found/presentation/pages/not-found_page.dart';
import 'package:d_report/src/feature/patients_details/presentation/pages/patient-details_page.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth/login/': (context) => const LoginPage(),
        '/auth/register/': (context) => const RegisterPage(),
        '/main/patients/': (context) => const MainPage(),
        '/main/patients/details/': (context) => const PatientDetailsPage(),
        '/main/profile/': (context) => const NotFoundPage(),
        '/main/config/': (context) => const NotFoundPage(),
      },
      initialRoute: '/auth/login/',
      onUnknownRoute: (RouteSettings setting) {
        //settings: setting;
          return MaterialPageRoute(
        builder: (context) => const NotFoundPage()
        );
      }
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
