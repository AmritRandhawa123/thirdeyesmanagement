import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookSession extends StatefulWidget {
  final String massageName;
  final String date;
  final int duration;
  final String spaName;
  final String subHeading;

  const BookSession(
      {super.key,
      required this.massageName,
      required this.date,
      required this.duration,
      required this.spaName,
      required this.subHeading});

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  String manager = FirebaseAuth.instance.currentUser!.email.toString();
  final db = FirebaseFirestore.instance;
  String dropdownValue = list.first;
  late List<dynamic> massagesName;
  static const List<String> list = <String>[
    'Deep Tissue',
    'Foot Massage',
    'Aroma Massage',
    'Full Body Massage'
  ];

  @override
  void initState() {
    check(widget.duration);
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
              const SizedBox(height: 20),
              CircleAvatar(
                  maxRadius: MediaQuery.of(context).size.width / 7,
                  child: Image.asset("assets/business.png")),
              const SizedBox(height: 10),
              const Text("Your booking manager"),
              Center(
                  child: Text(
                manager,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              )),
              const SizedBox(height: 15),
              Card(
                elevation: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Choose a massage service",
                            style: TextStyle(
                                fontFamily: "Montserrat", fontSize: 20)),
                      ),
                      const SizedBox(height: 15),
                      DropdownButton<String>(
                        itemHeight: 50,
                        onTap: () {},
                        value: dropdownValue,
                        icon: const Icon(Icons.add),
                        elevation: 15,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createBooking(String clientNumber, String spaName,
      String massage, double duration) async {
    await FirebaseFirestore.instance.enableNetwork();
    FirebaseFirestore.instance.collection("clients").doc(clientNumber).update({
      "pastServices": FieldValue.arrayUnion([
        {
          "spaName": spaName,
          "massageName": massage,
          "subHeading": "Sub Heading Pending",
          "duration": duration,
          "Date": DateFormat.yMMMd().add_jm().format(Timestamp.now().toDate()),
        }
      ]),
    });
  }

  void check(int massageType) {
    db
        .collection("clients")
        .doc("9953993916")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      var massages = documentSnapshot.get("pendingMassage");
      if (massages < massageType) {
        print("Sorry");
      } else {
        var data = massages * 60;
        var  d = massageType*60;
        print(data - d);
      }
    });
  }
}
