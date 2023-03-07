import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookSession extends StatefulWidget {
  final String number;
  final String clientName;
  final int pendingMassage;

  const BookSession(
      {super.key,
      required this.number,
      required this.clientName,
      required this.pendingMassage});

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
    check();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.clientName,
                    style: const TextStyle(fontSize: 22, fontFamily: "Dosis"),
                  )
                ],
              ),
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
    Timestamp timestamp = Timestamp.now();
    FirebaseFirestore.instance.collection("clients").doc(clientNumber).update({
      "pastServices": FieldValue.arrayUnion([
        {
          "spaName": spaName,
          "massage": massage,
          "duration": duration,
          "Date": DateFormat.yMMMd().add_jm().format(timestamp.toDate()),
          "bookingManager": manager
        }
      ]),
    });
  }

  void check() {
    db
        .collection("spaServices")
        .doc("Heritage Spa")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
         massagesName = documentSnapshot.get("allServices");
         for(int i  = 0; i < massagesName.length; i++){
           print(massagesName[i]["name"]);
           print(massagesName[i]["rate"]);
           print(massagesName[i]["subHeading"]);

         }

    });
  }
}
