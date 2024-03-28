import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolthrow/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() {
    return _UserInfoScreenState();
  }
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredUsername = '';

  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    await FirebaseFirestore.instance.collection('users').doc(_user!.uid).set({
      'username': _enteredUsername.toString(),
      'phoneNumber': _user!.phoneNumber,
    });
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TabsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.06, // Set opacity value between 0.0 and 1.0
                child: Image.asset(
                  'assets/images/Cart_girl.png',
                  // Replace with your image asset path
                  fit: BoxFit.cover, // Adjust width as needed
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          autocorrect: false,
                          maxLength: 19,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: 'Enter Your Name',
                            hintStyle: TextStyle(fontSize: 17),
                          ),
                          enableSuggestions: false,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 4) {
                              return 'Please enter a valid username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _enteredUsername = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF0A848A)),
                          ),
                          child: const Text(
                            'Lets Go',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
