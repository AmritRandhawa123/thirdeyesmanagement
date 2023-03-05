import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thirdeyesmanagement/modal/client_add.dart';
import 'package:thirdeyesmanagement/modal/client_details_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchController = TextEditingController();
  final GlobalKey<FormState> searchKey = GlobalKey<FormState>();

  bool loading = false;
  late dynamic _serverData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.systemGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientAdd(),
              ));
        },
        child: const Icon(Icons.people, color: Colors.white),
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text("Hey!",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.black54,
                  fontSize: 24)),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("How you feeling\nToday?",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: "Montserrat",
                  color: Colors.black54,
                  fontSize: 16)),
        ),
        const SizedBox(
          height: 10,
        ),
        Form(
          key: searchKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: searchController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter number";
                } else if (value.length < 10) {
                  return "Enter 10 digits";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Search Clients",
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.black54, size: 20),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
        Center(
          child: CupertinoButton(
              color: Colors.green,
              onPressed: () {
                if (searchKey.currentState!.validate()) {
                  loading = true;
                  String data = searchController.value.text.toString();
                  _searchClient(data);
                }
              },
              child: const Text("Search")),
        )
      ])),
    );
  }

  Future<void> _searchClient(String query) async {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(query)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        _serverData = documentSnapshot.data();
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClientAddDetails(
          phoneNumber: _serverData["phone"],
          name: _serverData["name"],
          age: _serverData["age"],
          amount: _serverData["amount"],
          massages: _serverData["massages"],
          pendingAmount: _serverData["pendingAmount"],
          pendingMassage: _serverData["pendingMassage"],
          registration: _serverData["registration"],
          pastServices: _serverData["pastServices"],

        ),));

      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("No Client Found"),
                  content: const Text(
                      "Make sure you have entered the correct number of the client? Please check and try again."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                ));
      }
    });
  }
}
