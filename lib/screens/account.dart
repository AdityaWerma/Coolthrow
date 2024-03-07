import 'package:coolthrow/screens/phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() {
    return _AccountScreen();
  }
}

class _AccountScreen extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen(),
                    ),);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                Image.asset(
                  'assets/images/Coolthrow_logo.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
                const Text('With love ❤︎, Coolthrow\n'),



              ],
            ),
          ),

        ],
      ),
    );
  }
}
