import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookSession extends StatefulWidget {
  const BookSession({Key? key}) : super(key: key);

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
 String manager =  FirebaseAuth.instance.currentUser!.email.toString();
  @override
  void initState() {
bookSession();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children:  [
        const Text("Booking by"),
        Center(child: Text(manager)),
      ],
    ),);
  }
}

Future<void> _createDatabase() async {

  Map<String,dynamic> data;

  FirebaseFirestore.instance.collection("clients").doc("9971953116").set({
data.map((key, value) => ){

    }
    "pastServices" :

  }, SetOptions(merge: true)).then((value) => {

  });
}
