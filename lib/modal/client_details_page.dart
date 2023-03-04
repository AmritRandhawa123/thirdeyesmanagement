import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientAddDetails extends StatefulWidget {
  const ClientAddDetails(
      {Key? key,
      required this.name,
      required this.age,
      required this.balancePending,
      required this.activeStatus,
      required this.paid,
      required this.phoneNumber,
      required this.pendingMassage,
      required this.plan,
      required this.services})
      : super(key: key);
  final String name;
  final int age;
  final int balancePending;
  final bool activeStatus;
  final int paid;
  final String phoneNumber;
  final int pendingMassage;
  final int plan;
  final List<dynamic> services;

  @override
  State<ClientAddDetails> createState() => _ClientAddDetailsState();
}

class _ClientAddDetailsState extends State<ClientAddDetails> {
@override
  void initState() {
    load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );

  }


void load() {
  print(widget.name);
  print(widget.phoneNumber);
  print(widget.activeStatus);
  print(widget.age);
  print(widget.balancePending);
  print(widget.pendingMassage);
  print(widget.paid);

 print(widget.services);
    // print(widget.services[0]["spaName"]);
    // print(widget.services[0]["massageName"]);
    // print(widget.services[0]["duration"]);
    // Timestamp timestamp = widget.services[0]["time"];
    // print( timestamp.toDate());
  }

}
