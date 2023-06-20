import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/pages/login_page.dart';
import 'package:task_manager/features/auth/pages/otp_page.dart';
import 'package:task_manager/features/onboarding/pages/onboarding.dart';
import 'package:task_manager/features/todo/pages/homepage.dart';

class Routes {
  static const String HOME = "home";
  static const String ONBOARDING = "onboarding";
  static const String LOGIN = "login";
  static const String OTP = "otp";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name){
      case ONBOARDING:
        return MaterialPageRoute(builder: (context) => const Onboarding());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case OTP:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(builder: (context) => OtpPage(smsCodeId: args["smsCodeId"], phoneNumber: args["phoneNumber"],));
      case HOME:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
      return MaterialPageRoute(builder:  (context) => const HomePage());
    }
  }
}