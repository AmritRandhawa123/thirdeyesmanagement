import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Image.asset(
                  "assets/logo.png",
                ),
              )),
          const SizedBox(
            height: 20,
          ),
           const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFe09d31),
            ),
          ),
        ],
      ),
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
      if (e.code == "user-disabled") {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => const UserDisabled(),
        // ));
      }
      print(e.code);
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
      moveToGettingStart();
    } else {
      moveToDecision();
    }
  }

  Future<void> moveToHome() async {
    if(mounted){
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
    }

  }
}
