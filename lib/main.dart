import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thirdeyesmanagement/screens/decision.dart';
import 'package:thirdeyesmanagement/screens/getting_started_screen.dart';
import 'package:thirdeyesmanagement/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(seconds: 2), () {
              userState();
            }));
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: CupertinoColors.systemGreen,)),
    ); // widget tree
  }

  Future<void> userState() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser != null) {
        moveToHome();
      } else {
       await userStateSave();
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if(e.code == "user-disabled"){
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => const UserDisabled(),
        // ));
      }

    }
  }

  moveToDecision() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Decision(),
    ));
  }
  moveToGettingStart() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const GettingStartedScreen(),
    ));
  }


  Future<void> userStateSave() async {
    final value = await SharedPreferences.getInstance();
    if (value.getInt("userState") != 1) {
moveToGettingStart();    }
    else{
      moveToDecision();
    }
  }

  void moveToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Home(),
    ));
  }
}
