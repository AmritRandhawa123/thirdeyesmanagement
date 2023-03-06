import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookSession extends StatefulWidget {
  final String number;
  final String clientName;

  const BookSession({super.key, required this.number, required this.clientName});

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  String manager = FirebaseAuth.instance.currentUser!.email.toString();
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    db.terminate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text("Booking Manager"),
              Center(child: Text(manager)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  const Text("Booking creating for"),
                  Text(widget.clientName,style: const TextStyle(fontSize: 22,fontFamily: "Dosis"),)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Future<void> createBooking(String clientNumber,String spaName, String massage, double duration) async {
    await FirebaseFirestore.instance.enableNetwork();
    Timestamp timestamp = Timestamp.now();
    FirebaseFirestore.instance.collection("clients").doc(clientNumber).update({
      "pastServices": FieldValue.arrayUnion([
        {
          "spaName": spaName,
          "massage": "massage",
          "duration": duration,
          "Date":   DateFormat.yMMMd().add_jm().format(timestamp.toDate())
        }
      ]),
    });
  }
}
