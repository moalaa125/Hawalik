import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawalik/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hawalik/constants/strings.dart';
import 'package:hawalik/presentation/screens/OTP_screen.dart';
import 'package:hawalik/presentation/screens/login_screen.dart';
import 'package:hawalik/presentation/screens/map_screen.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }
  Route? genirateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,

            child: LoginScreen(),
          ),
        );
      case otpScreeen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,

            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: MapScreen(),
          ),
        );
    }
    return null;
  }
}
