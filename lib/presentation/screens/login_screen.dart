import 'package:flutter/material.dart';
import 'package:hawalik/constants/mycolors.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, this.phoneNumber});

  String? phoneNumber;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Whats Your Phone Number?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'Please Enter Your Phone Number To Verify Your account.',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              generateCountryFlag() + ' +20',
              style: TextStyle(fontSize: 18, letterSpacing: 2.0),
            ),
          ),
        ),

        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Mycolors.blue),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                } else if (value.length < 11) {
                  return 'Please Enter A Valid Number';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
              keyboardType: TextInputType.phone,
              cursorColor: Colors.black,
              autofocus: true,
              style: TextStyle(fontSize: 18, letterSpacing: 2.0),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
    return flag;
  }

  Widget _buildNextButton() {
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
        child: Text('Next', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(  
          key: UniqueKey(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroTexts(),
                SizedBox(height: 20),
                _buildPhoneNumberField(),
                SizedBox(height: 70),
            
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
