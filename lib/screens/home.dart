import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thirdeyesmanagement/modal/account_setting.dart';

import '../modal/client_add.dart';
import '../modal/client_details_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  final searchController = TextEditingController();
  final GlobalKey<FormState> searchKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .50;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[100],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientAdd(),
                    ));
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.people,
                color: Theme.of(context).primaryColor,
              ),
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
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "Today's Sale",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 36.0,
            ),
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Image.asset("assets/saleSlider.png"),
           )
          ],
        ));
  }

  Widget _body() {
    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                Text("Hey!",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.black87,
                        fontSize: 24)),
                Text("How you feeling\nToday?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: "Montserrat",
                        color: Colors.black54,
                        fontSize: 16)),
              ],
            ),
            Column(
              children:  [
                GestureDetector(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSetting(),));
                  },
                  child: const CircleAvatar(
backgroundColor: Colors.green,
                    child: Icon(Icons.account_circle_outlined,color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Form(
        key: searchKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                counterText: "",
                filled: true,
                hintText: "Search Registered Clients",
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
      const SizedBox(
        height: 5,
      ),
      loading ? const Center(child: CircularProgressIndicator()) : Container(),
      const SizedBox(
        height: 5,
      ),
      Center(
        child: CupertinoButton(
            color: Colors.green,
            onPressed: () {

              if (searchKey.currentState!.validate()) {

                setState(() {
                  loading = true;
                });
                _searchClient(searchController.value.text.toString());
              }
            },
            child: const Text("Search")),
      ),
      const SizedBox(
        height: 20,
      ),
      Center(
        child: CupertinoButton(
            color: Colors.deepPurple,
            onPressed: () {},
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.directions_walk,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Walk-in Client",
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
            )),
      )
    ]));
  }

  Future<void> _searchClient(String query) async {

    await db
        .collection('clients')
        .doc(query)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          loading = false;
        });


        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClientAddDetails(
                phoneNumber: documentSnapshot["phone"],
                member: documentSnapshot["member"],
                name: documentSnapshot.get("name"),
                age: documentSnapshot.get("age"),
                amount: documentSnapshot.get("amount"),
                massages:    documentSnapshot.get("massages"),
                pendingAmount: documentSnapshot.get("pendingAmount"),
                pendingMassage: documentSnapshot.get("pendingMassage"),
                registration: documentSnapshot.get("registration"),
                pastServices: documentSnapshot.get("pastServices"),
              ),
            ));
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("No Client Found",
                      style: TextStyle(color: Colors.red)),
                  content: const Text(
                      "Make sure you have entered the correct number of the client? Please check and try again."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text("Ok"))
                  ],
                ));
        setState(() {
          loading = false;
        });
      }
    });
  }
}
