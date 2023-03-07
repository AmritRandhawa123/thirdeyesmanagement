
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
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
                      borderRadius: const BorderRadius.all(Radius.circular(12.0))),
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
           Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("Images",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),

                ],
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("About",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
                  """,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }


  Widget _body() {
    return SafeArea(
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
                    color: Colors.black87,
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
          loading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
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
                  width: MediaQuery.of(context).size.width/2,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.directions_walk,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10,),
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
                name: documentSnapshot.get("name"),
                age: documentSnapshot.get("age"),
                amount: documentSnapshot.get("amount"),
                massages: documentSnapshot.get("massages"),
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