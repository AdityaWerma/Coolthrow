import 'package:flutter/material.dart';
import 'package:coolthrow/screens/tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a long-running task, such as loading data or initializing the app
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the next screen after the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TabsScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Image.asset('assets/images/Coolthrow_logo.png',width: 200,height: 200,),
      ),
    );
  }
}