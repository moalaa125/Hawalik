import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hawalik/app_router.dart';
import 'package:hawalik/constants/strings.dart';
import 'package:hawalik/firebase_options.dart';

late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    initialRoute = loginScreen;
  } else {
    initialRoute = mapScreen;
  }
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      onGenerateRoute: appRouter.genirateRoute,
      initialRoute: initialRoute,
    );
  }
}
