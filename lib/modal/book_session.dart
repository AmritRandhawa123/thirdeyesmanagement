import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookSession extends StatefulWidget {
  final int pendingMassages;
  final int phoneNumber;

  const BookSession({super.key, required this.pendingMassages, required this.phoneNumber});

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  late List<dynamic> values;

  // Initial Selected Value
  String dropDownValue = 'Choose Spa';

  // List of items in our dropdown menu
  var items = [
    'Choose Spa',
    'Heritage Spa',
    'Golden Spa',
    'Holistic Spa',
    'Sparsh Spa',
    'Ayurveda Spa',
  ];
  String manager = FirebaseAuth.instance.currentUser!.email.toString();
  final db = FirebaseFirestore.instance;

  bool fetched = false;

  final pc = PanelController();
  double panelHeightClosed = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    db.terminate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var panelHeightOpen = MediaQuery.of(context).size.height - 200;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff2b6747),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            controller: pc,
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: fetched
            ? ListView.separated(

                itemCount: values.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 5),
                itemBuilder: (BuildContext context, int index) {

                  int sNo = index + 1;
                  return GestureDetector(
                    onTap: (){
                    createBooking(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("$sNo. "),
                                Text(values[index]["spaName"],
                                    style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Massage : "),
                                Text(values[index]["massageName"],
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat")),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Description : "),
                                Flexible(
                                  child: Text(values[index]["subHeading"],
                                      softWrap: false,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat")),
                                ),
                                const SizedBox(width: 10),
                                const Text("Rate : "),
                                Text(values[index]["rate"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat"))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Duration : ",
                                ),
                                Text(values[index]["duration"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat")),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              )
            : Container());
  }

  Widget _body() {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Card(
            margin: const EdgeInsets.all(30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: DropdownButton(
                  iconSize: 40,
                  value: dropDownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    if (newValue == "Choose Spa") {
                      return;
                    } else {
                      check(newValue!);
                      setState(() {
                        dropDownValue = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              const Text("Booking Manager",style: TextStyle(fontSize: 18)),
              Text(manager,
                  style: const TextStyle(
                      fontFamily: "Montserrat", fontWeight: FontWeight.w500,)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            child: ClipPath(
              clipper: ClipPathClass(),
              child: SizedBox(
                width: 320,
                height: 320,
                child: Flexible(
                  child: Image.asset(
                    "assets/booking.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> createBooking(int index) async {

    await FirebaseFirestore.instance.enableNetwork();
    FirebaseFirestore.instance.collection("clients").doc(widget.phoneNumber.toString()).update({
      "pastServices": FieldValue.arrayUnion([
        {
          "spaName": values[index]["spaName"],
          "massageName": values[index]["massageName"],
          "subHeading": values[index]["subHeading"],
          "duration": values[index]["duration"],
          "rate": values[index]["rate"],
          "date": DateFormat.yMMMd().add_jm().format(Timestamp.now().toDate()),
        }
      ]),
    });
  }

  Future<void> check(String massageType) async {
    try {
      await db
          .collection("spaServices")
          .doc(massageType)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          values = documentSnapshot.get("service");
          pc.open();
          panelHeightClosed = MediaQuery.of(context).size.height / 3.5;
          setState(() {
            fetched = true;
          });
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Coming Soon")));
    }
  }
}
class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}