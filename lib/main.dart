import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:start_project/firebase_options.dart';
import 'brand_profile_pages/screens/main_screen_brand_profile.dart';
import 'grad/logo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
