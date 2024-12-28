import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/firebase_options.dart';
import 'package:food_hub_user/view/auth/signup_screen.dart';
import 'package:get/get.dart';

import 'services/get_storage_services.dart';

void main() async {
  await GetStorageServices.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'sp',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignupScreen(),
    );
  }
}
