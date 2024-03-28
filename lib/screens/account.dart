import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolthrow/screens/phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() {
    return _AccountScreen();
  }
}

class _AccountScreen extends State<AccountScreen> {
  User? _user;
  var _username = '';
  

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser!;
    setState(() {
      _user = user;
    });
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      setState(() {
        _username = snapshot['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Contact Number: ${_user!.phoneNumber}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 83, 83),
                  ),
                ),
                Text(
                  'Username: ${_username.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 83, 83),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const PhoneNumberScreen(),
                      ),
                    );
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
