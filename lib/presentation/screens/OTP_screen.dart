import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawalik/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hawalik/constants/mycolors.dart';
import 'package:hawalik/constants/strings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.phoneNumber});

  final phoneNumber;

  late String otpCode;

  // String? otpCode = '';
  bool isLoading = false;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Your Phone number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter Your 6 digit code number sent to you at ',
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: phoneNumber,
                  style: TextStyle(
                    color: Mycolors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpCodeSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: MaterialPinField(
        autoDismissKeyboard: true,
        keyboardType: TextInputType.number,
        length: 6,
        onCompleted: (otp) => otpCode = otp,
        onChanged: (value) => print('Changed: $value'),
        theme: MaterialPinTheme(
          borderColor: Mycolors.blue,
          filledFillColor: Mycolors.LighBlue,
          focusedBorderColor: Mycolors.blue,
          cursorColor: Colors.black,
          fillColor: Colors.white,
          disabledColor: Colors.white,
          focusedFillColor: Colors.white,
          animateCursor: true,
          animationDuration: Duration(milliseconds: 200),
          shape: MaterialPinShape.outlined,
          cellSize: Size(50, 50),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDontRecieveCodeSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Don\'t Recieve verification code ?',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'change the number',
                    style: TextStyle(color: Mycolors.blue),
                  ),
                ),
              ),
              VerticalDivider(
                width: 0,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => null,
                  child: Text(
                    'resend code',
                    style: TextStyle(color: Mycolors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: Size(110, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(6),
          ),
        ),
        onPressed: () {
          _login(context);
        },
        child: Text('Verify', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _showProgressLoading(BuildContext context) {
    if (isLoading == true) {
      showDialog(
        context: context,
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
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          _showProgressLoading(context);
        }
        if (state is phoneOtpVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }
        if (state is ErrorOccured) {
          // Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 30),

            child: Column(
              children: [
                _buildIntroTexts(),
                SizedBox(height: 60),
                _buildOtpCodeSection(),
                SizedBox(height: 30),
                _buildVerifyButton(context),
                SizedBox(height: 30),
                _buildDontRecieveCodeSection(context),
                _buildPhoneVerificationBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
