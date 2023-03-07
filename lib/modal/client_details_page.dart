import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book_session.dart';

class ClientAddDetails extends StatefulWidget {
  const ClientAddDetails({Key? key,
    required this.name,
    required this.age,
    required this.massages,
    required this.pendingAmount,
    required this.pendingMassage,
    required this.amount,
    required this.phoneNumber,
    required this.registration,
    required this.pastServices,})
      : super(key: key);
  final String name;
  final int age;
  final double massages;
  final int pendingAmount;
  final int pendingMassage;
  final int amount;
  final String phoneNumber;
  final String registration;
  final List<dynamic> pastServices;


  @override
  State<ClientAddDetails> createState() => _ClientAddDetailsState();
}

class _ClientAddDetailsState extends State<ClientAddDetails> {

  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text("Welcome,"),
                            SizedBox(width: 10),
                                Text("Name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700)),
                              ],
                            ),
                            Text(widget.name,
                                style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.bold)),
                            const Text("Age"),
                            Text(widget.age.toString(),
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(children: [
                          const Text("Plan activate"),
                          Text(widget.amount.toString(),
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontFamily: "Dosis",
                                  fontWeight: FontWeight.bold)),

                        ],)
                      ],
                    )),
              ),
              widget.pastServices.isEmpty ? Container() :
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemCount: widget.pastServices.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(widget.pastServices[index]["spaName"]),
                      trailing: Column(children: [
                        Text(widget.pastServices[index]["massageName"]),
                        Text("${widget.pastServices[index]["duration"]} Hrs")
                      ]),
                      subtitle: const Text("Hello"),
                    );
                  },
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                ),
              ),
              CupertinoButton(
                color: CupertinoColors.systemGreen,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  =>
                      BookSession(number: widget.phoneNumber,
                        clientName: widget.name,
                        pendingMassage: widget.pendingMassage),)
                  );
                },
                child: const Text("Book Session"),)


            ],
          ),
        ));
  }
}
