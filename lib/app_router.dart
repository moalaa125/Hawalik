import 'package:flutter/material.dart';
import 'package:hawalik/constants/strings.dart';
import 'package:hawalik/presentation/screens/OTP_screen.dart';
import 'package:hawalik/presentation/screens/login_screen.dart';

class AppRouter {
  Route? genirateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case otpScreeen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
    }
    return null;
  }
}
