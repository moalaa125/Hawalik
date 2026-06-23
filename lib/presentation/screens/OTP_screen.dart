import 'package:flutter/material.dart';
import 'package:hawalik/constants/mycolors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});

  final PhoneNumber = '+201024299900';
   String? otpCode = '';

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
                  text: PhoneNumber,
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
        length: 6,
        onCompleted: (otp) => otpCode = otp  , // todo: lasa h3ml el logic 
        onChanged: (value) => print('Changed: $value'), // todo: lasa h3ml el logic 
        theme: MaterialPinTheme(
          borderColor: Mycolors.blue,
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

  Widget _buildDontRecieveCodeSection() {
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
                  onPressed: null,
                  child: Text(
                    'resend code',
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
                  onPressed: null,
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

  Widget _buildVerifyButton() {
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
          // todo: lsa h3mlha
        },
        child: Text('Verify', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 30),

          child: Column(
            children: [
              _buildIntroTexts(),
              SizedBox(height: 60),
              _buildOtpCodeSection(),
              SizedBox(height: 30),
              _buildVerifyButton(),
              SizedBox(height: 30),
              _buildDontRecieveCodeSection(),
            ],
          ),
        ),
      ),
    );
  }
}
