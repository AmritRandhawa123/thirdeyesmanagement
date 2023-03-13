import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthFirebase extends StatefulWidget {
  final String number;
  final String countryCode;
  final TextEditingController previousController;
  final Duration initialDelay = const Duration(seconds: 1);

  const PhoneAuthFirebase(
      {super.key,
      required this.number,
      required this.countryCode,
      required this.previousController});

  @override
  PhoneAuthFirebaseState createState() => PhoneAuthFirebaseState();
}

class PhoneAuthFirebaseState extends State<PhoneAuthFirebase> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpKey = GlobalKey();

  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  @override
  void initState() {
 verifyUserPhoneNumber();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(50),
                child: Image.asset("assets/saleSlider.png",
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2.5),
              ),
            ),
            const Text(
              "An one time password has been sent to",
              style: TextStyle(fontFamily: "QuickSand", color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.countryCode + widget.number,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  child: const Text(
                    "Change Number?",
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            const SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                key: otpKey,
                child: PinCodeTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter otp";
                    } else if (value.length != 6) {
                      return "Enter 6 digits otp";
                    } else {
                      return null;
                    }
                  },
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  appContext: context,
                  length: 6,
                  onChanged: (String value) {},
                ),
              ),
            ),
            Center(
              child: CupertinoButton(
                onPressed: () async {
                  if (otpKey.currentState!.validate()) {
                    verifyOTPCode();
                  }
                },
                color: Colors.black,
                child: const Text(
                  "Proceed",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            enableResend
                ? TextButton(
                onPressed: () {
                  secondsRemaining = 30;
                  enableResend = false;
                },
                child: const Text(
                  "Resend",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Dosis",
                  ),
                ))
                : TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Resend OTP in",
                      style: TextStyle(
                          color: Colors.black, fontFamily: "Dosis"),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      secondsRemaining.toString(),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  var receivedID = "";

  void verifyUserPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "91${widget.number}",
      verificationCompleted: (PhoneAuthCredential credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: otpController.value.text,
    );
    await auth
        .signInWithCredential(credential)
        .then((value) => print('User Login In Successful'));
  }
}