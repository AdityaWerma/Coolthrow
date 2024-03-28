import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolthrow/screens/phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/screens/tabs.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  User? _user;
  var _username;

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });

    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(user!.uid).get();
    if (snapshot.exists) {
      setState(() {
        _username = snapshot['username'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();

    // Simulate a long-running task, such as loading data or initializing the app
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the next screen after the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.hasData && _username != null) {
                return const TabsScreen();
              }
              return const PhoneNumberScreen();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/Coolthrow_logo.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
