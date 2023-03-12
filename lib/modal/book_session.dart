import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookSession extends StatefulWidget {
  final int pendingMassages;
  final int phoneNumber;

  const BookSession(
      {super.key, required this.pendingMassages, required this.phoneNumber});

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  late List<dynamic> values;
  List<dynamic> finalize = [];

  String dropDownValue = 'Choose Spa';

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

  final PanelController _pc1 = PanelController();
  final PanelController _pc2 = PanelController();
  bool _visible = true;
  double panelHeightClosed = 0;

  bool loaded = false;

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

  late int ind;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff2b6747),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: _visible,
            child: SlidingUpPanel(
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(),
              controller: _pc1,
              panelBuilder: (sc) => _panel(sc),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: !_visible,
            child: SlidingUpPanel(
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(),
              controller: _pc2,
              panelBuilder: (sc) => _panel2(sc),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
            ),
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
                    onTap: () async {
                      await addCart(index);
                      _pc1.close();
                      _visible = false;
                      setState(() {});
                      _pc2.open();
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

  Widget _panel2(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _pc2.close();
                        _visible = true;
                        setState(() {});
                        _pc1.open();
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          Text("Add More"),
                        ],
                      )),
                ],
              ),
              ListView.separated(
                itemCount: finalize.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 5),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(finalize[index]["massageName"],
                            style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: (){
                            .document('docID').updateData('': FieldValue.arrayRemove([{0}]));
                          },
                          child: const Icon(
                            Icons.remove_circle_outlined,
                            color: Colors.redAccent,
                          ),
                        )
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
              CupertinoButton(
                color: CupertinoColors.activeGreen,
                onPressed: () {},
                child: const Text("Confirm Booking"),
              )
            ],
          ),
        ));
  }

  Widget _body() {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 20),
          Column(
            children: [
              const Text("Booking Manager", style: TextStyle(fontSize: 18)),
              Text(manager,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
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
                      setState(() {
                        dropDownValue = newValue!;
                      });
                      panelHeightClosed = 0;
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
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            child: ClipPath(
              clipper: ClipPathClass(),
              child: SizedBox(
                width: 320,
                height: 320,
                child: Image.asset(
                  "assets/booking.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> createBooking(int index) async {
    await db.enableNetwork();
    db.collection("cache").doc("data").update({
      "service": FieldValue.arrayUnion([
        {
          "spaName": values[index]["spaName"],
          "massageName": values[index]["massageName"],
          "subHeading": values[index]["subHeading"],
          "duration": values[index]["duration"],
          "rate": values[index]["rate"],
        }
      ]),
    });
  }

  Future<void> addCart(int index) async {
    await db.enableNetwork();
    db.collection("clients").doc(widget.phoneNumber.toString()).update({
      "cart": FieldValue.arrayUnion([
        {
          "spaName": values[index]["spaName"],
          "massageName": values[index]["massageName"],
          "subHeading": values[index]["subHeading"],
          "duration": values[index]["duration"],
          "rate": values[index]["rate"],
        }
      ]),
    });

    await db
        .collection("clients")
        .doc(widget.phoneNumber.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        finalize = documentSnapshot.get("cart");
        setState(() {
          loaded = true;
        });
      }
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
