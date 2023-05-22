import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'registration_api_connection/users/authentication/login_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();  // to avoid empty white screen
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clothes App',
      debugShowCheckedModeBanner: false,  // to remove debuge sign
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(
          builder: (context,dataSnapShot)
    {
      return LoginScreen();
    },
      ),
    );
  }
}


