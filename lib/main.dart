import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/firebase_options.dart';
import 'package:food_hub_user/view/auth/splash_screen.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'services/get_storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorageServices.init();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'sp',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
