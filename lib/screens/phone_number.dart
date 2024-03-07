import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  static String verify = '';

  @override
  State<PhoneNumberScreen> createState() {
    return _PhoneNumberScreenState();
  }
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  var phoneNumber = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    List<String> inputList = List.filled(6, ''); // List to store input

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
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

          Column(children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/Coolthrow_logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                'Coolthrow will need to verify your account. As we are only available in india, +91 is automatically added.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                child: Column(children: [
                  Container(
                    width: 250,
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Border color
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),
                      autocorrect: false,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: 'Enter the phone number',
                        hintStyle: TextStyle(fontSize: 17),
                      ),
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      controller: _phoneNumberController,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91$phoneNumber',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          PhoneNumberScreen.verify = verificationId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                        phNum: phoneNumber,
                                      )));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF0A848A)),
                    ),
                    child: const Text("Send OTP",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
