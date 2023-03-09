import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirdeyesmanagement/screens/decision.dart';
import 'package:thirdeyesmanagement/screens/password_reset.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcf0ff),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  const Text("Welcome", style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 10),
                  Text(FirebaseAuth.instance.currentUser!.email.toString(),
                    style: const TextStyle(
                        fontFamily: "Montserrat", fontSize: 18),)
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset("assets/addClient.png",
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3.5, width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.5),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CupertinoButton(
                      color: Colors.purple[300],
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          _logout();
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.code.toString())));
                        }
                      }, child: const Text("Sign-Out")),
                  const SizedBox(height: 30),
                  CupertinoButton(
                      color: Colors.redAccent[200],
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const PasswordReset(),));
                      }, child: const Text("Change Password")),
                  const SizedBox(height: 30),
                ],
              ),

            ]),
      ),
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Decision(),), (route) => false);
  }
}