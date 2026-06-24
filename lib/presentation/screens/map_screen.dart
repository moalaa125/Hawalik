// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawalik/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:hawalik/constants/strings.dart';
// import 'package:hawalik/presentation/screens/login_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          child: BlocProvider(
            create: (context) => phoneAuthCubit,
            child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(110, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(6),
                    ),
                  ),
                  onPressed: ()  async{
                  await phoneAuthCubit.logOut();
                  Navigator.of(context).pushReplacementNamed(loginScreen);
                  },
                  child: Text('Map', style: TextStyle(color: Colors.white)),
                ),
          ),
        ),
      ),
    );
  }
}