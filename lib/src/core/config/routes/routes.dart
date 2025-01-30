import 'package:flutter/material.dart';

import 'package:d_report/src/feature/auth/presentation/pages/login_page.dart';
import 'package:d_report/src/feature/auth_register/presentation/page/register_page.dart';
import 'package:d_report/src/feature/main_page/presentation/pages/main_page.dart';
import 'package:d_report/src/feature/main_page_find/presentation/page/main_page_find.dart';
import 'package:d_report/src/feature/new_follow/presentation/pages/new_follow_case_page.dart';
import 'package:d_report/src/feature/patient_case_doctors/presentation/pages/patient_case_doctors_page.dart';
import 'package:d_report/src/feature/patient_case_follow_details/presentation/pages/patient_case_follow_details_page.dart';
import 'package:d_report/src/feature/patients_details/presentation/pages/patient-details_page.dart';
import 'package:d_report/src/feature/end_case/presentation/page/end_case_page.dart';
import 'package:d_report/src/feature/find_patient/presentation/pages/find_patient_page.dart';
import 'package:d_report/src/feature/new_case/presentation/pages/new_case_page.dart';
import 'package:d_report/src/feature/new_patient/presentation/pages/new_patient_page.dart';
import 'package:d_report/src/feature/patient_case_edit_case/presentation/pages/patient_case_edit_case_page.dart';
import 'package:d_report/src/feature/patient_case_edit_patient/presentation/pages/patient_case_edit_patient_page.dart';
import 'package:d_report/src/feature/patient_case_edit_patient_guardian/presentation/pages/patient_case_edit_guardian_page.dart';
import 'package:d_report/src/feature/patient_case_edit_selector/presentation/pages/patient_case_selector_page.dart';
import 'package:d_report/src/feature/profile_user/presentation/pages/profile_page.dart';
import 'package:d_report/src/feature/profile_user_edit/presentation/pages/edit_profile_page.dart';
import 'package:d_report/src/feature/settings/presentation/pages/settings_page.dart';
import 'package:d_report/src/feature/settings_operations/presentation/pages/settings_operations_page.dart';
import 'package:d_report/src/shared/presentation/pages/information_page.dart';

import '../../../feature/not_found/presentation/pages/not-found_page.dart';

String getInitialRoute() {
  return '/auth/login/';
}

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder> {
    '/auth/login/': (context) => const LoginPage(),
    '/auth/register/': (context) => const RegisterPage(),
    '/main/patients/': (context) => const MainPage(),
    '/main/patients/find/': (context) => const MainPageFind(),
    '/main/patients/details/': (context) => const PatientDetailsPage(),
    '/main/patients/details/doctors': (context) => const PatientCaseDoctorsPage(),
    '/main/patients/details/follow-case': (context) => const PatientFollowCaseDetailsPage(),
    '/main/patients/details/create-follow-case': (context) => const NewFollowCasePage(),
    '/main/patients/details/edit-case': (context) => const PatientEditPageSelector(),
    '/main/patients/details/edit-case/patient': (context) => const EditCasePatientPage(),
    '/main/patients/details/edit-case/patient-guardian': (context) => const EditCasePatientGuardianPage(), //NotFoundPage(),
    '/main/patients/details/edit-case/case': (context) => const EditCaseCasePage(),
    '/main/patients/details/end-case': (context) => const EndCasePage(),
    '/main/profile/': (context) => const ProfilePage(),
    '/main/profile/edit-row': (context) => const EditProfilePage(dataField: 'pepe',), // TODO CHANGE
    '/main/config/': (context) => const SettingsPage(),
    '/main/config/edit/': (context) => const SettingsOperationsPage(),
    '/main/new-case/new-patient': (context) => const NewPatientPage(),
    '/main/new-case/find-patient': (context) => const FindPatientPage(),
    '/main/new-case/add-case': (context) => const NewCasePage(),
    '/main/information/': (context) => const InformationPage(),
  };
}

MaterialPageRoute getNotFoundRoute() {
  return MaterialPageRoute(builder: (context) => const NotFoundPage());
}