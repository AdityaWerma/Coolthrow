import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coolthrow/screens/splash.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
    background: Colors.white,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coolthrow',
      theme: theme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
