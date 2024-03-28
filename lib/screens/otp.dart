import 'package:coolthrow/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coolthrow/screens/phone_number.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phNum});

  final phNum;

  @override
  State<OTPScreen> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends State<OTPScreen> {
  var otp = '';

  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
    _controllers = List.generate(6, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOTP() {
    // Concatenate values from all text controllers
    String otp = '';
    for (var controller in _controllers) {
      otp += controller.text;
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    var phoneNumber = widget.phNum;
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
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  'We have sent the OTP through SMS on +91$phoneNumber',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                        (index) =>
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _controllers[index],
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                            keyboardType: TextInputType.number,
                            autofocus: index == 0 ? true : false,
                            focusNode: _focusNodes[index],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 5) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index + 1]);
                                }
                              } else {
                                if (index > 0) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index - 1]);
                                }
                              }
                              otp = getOTP();
                            },
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                        verificationId: PhoneNumberScreen.verify,
                        smsCode: otp,
                      );
                      await auth.signInWithCredential(credential).then(
                            (value) =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserInfoScreen())));
                    } catch (e) {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content:
                              const Text("Invalid OTP. Please try again."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF0A848A)),
                  ),
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
