// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawalik/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hawalik/constants/strings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:hawalik/presentation/screens/login_screen.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key, required this.phoneNumber});

  final phoneNumber;

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget _buldPhoneNumberSubmittedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          _showProgressLoading(context);
        } else if (state is ErrorOccured) {
          Navigator.pop(context);
        }
        if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreeen, arguments: phoneNumber);
        }
        if (state is ErrorOccured) {
          Navigator.pop(context);
          String errorMessage = (state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              content: Text(errorMessage),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _showProgressLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents user from tapping outside to close it
      builder: (BuildContext context) {
        return Center(
          child: LoadingAnimationWidget.threeRotatingDots(
            color: Colors.black,
            size: 50,
          ),
        );
      },
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, loginScreen);
      },
      child: Text('back'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _buildBackButton(context)));
  }
}
