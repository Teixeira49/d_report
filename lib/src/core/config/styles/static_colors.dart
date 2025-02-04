import 'package:flutter/material.dart';

class ColorPalette {

  static const Color badgeHistory = Color(0xEFC15FFA);
  static const Color badgeActualRoom= Color(0xEFFF77E5);
  static const Color badgeActiveCase = Color(0xFEA1FF56);
  static const Color badgeFinishCaseDead = Color(0xFFF34E31);
  static const Color badgeFinishCaseSurvive = Color(0xFE18FA35);
  static const Color badgeFinishCaseEscaped = Color(0xFFFDC642);
  static const Color badgeFinishCaseReferral = Color(0xFFDDEC26);
  static const Color badgeDoctorSpeciality = Colors.greenAccent;

  static const Color checkColor = Colors.green;

  static const List<Color> activeCase = [
    Colors.green,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.limeAccent,
  ];

  static const List<Color> disabledCase = [
    Colors.pink,
    Colors.red,
    Colors.amber,
  ];

  static Color selectByEndStatus(status) {
    switch (status) {
      case 'SURVIVE':
        return badgeFinishCaseSurvive;
      case 'ESCAPED':
        return badgeFinishCaseEscaped;
      case 'REFERRAL':
        return badgeFinishCaseReferral;
      case 'DEAD':
        return badgeFinishCaseDead;
      default:
        return badgeActiveCase;
    }
  }
}
