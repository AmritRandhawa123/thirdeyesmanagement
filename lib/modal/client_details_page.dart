import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientAddDetails extends StatefulWidget {
  const ClientAddDetails(
      {Key? key,
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
  final int massages;
  final int pendingAmount;
  final int pendingMassage;
  final int amount;
  final String phoneNumber;
  final Timestamp registration;
  final List<dynamic> pastServices;


  @override
  State<ClientAddDetails> createState() => _ClientAddDetailsState();
}

class _ClientAddDetailsState extends State<ClientAddDetails> {

  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name"),
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
          widget.pastServices.isNotEmpty ?
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
          ) : Container()
        ],
      ),
    ));
  }
}
