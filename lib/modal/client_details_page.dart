
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


import 'book_session.dart';

class ClientAddDetails extends StatefulWidget {
  const ClientAddDetails({
    Key? key,
    required this.name,
    required this.member,
    required this.age,
    required this.massages,
    required this.pendingAmount,
    required this.pendingMassage,
    required this.amount,
    required this.phoneNumber,
    required this.registration,
    required this.pastServices,
  }) : super(key: key);
  final String name;
  final bool member;
  final int age;
  final int massages;
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
  final pc = PanelController();
  @override
  Widget build(BuildContext context) {
    final double panelHeightClosed = MediaQuery.of(context).size.height / 3.5;

    var panelHeightOpen = MediaQuery.of(context).size.height * .60;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff2b6747),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              pc.open();
            },

            child: SlidingUpPanel(
              onPanelClosed: () {
                pc.close();
              },
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              color: const Color(0xFFedfff6),
              body: _body(),
              controller: pc,
              panelBuilder: (sc) => _panel(sc),
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
        child: widget.pastServices.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 5,
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/clientSlider.png"),
                  ),
                  const Text("You haven't taken any service yet",
                      style: TextStyle(fontSize: 16, fontFamily: "Montserrat")),
                ],
              )
            : ListView.separated(
                itemCount: widget.pastServices.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 5),
                itemBuilder: (BuildContext context, int index) {
                  int sNo = index + 1;
                  return Container(
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
                              Text(widget.pastServices[index]["spaName"],
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 5),
                              Text(widget.pastServices[index]["date"],
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
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
                              Text(widget.pastServices[index]["massageName"],
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
                                child: Text(
                                    widget.pastServices[index]["subHeading"],
                                    softWrap: false,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat")),
                              )
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
                              Text(widget.pastServices[index]["duration"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat")),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ));
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 30,
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                    )),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Welcome,",
                        style: TextStyle(fontSize: 16, color: Colors.white60)),
                    Row(
                      children: [
                        Text(widget.name,
                            style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Montserrat")),
                        const SizedBox(width: 10),
                        Text(widget.age.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 5),
                        const Text(
                          "Yrs",
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              height: 30,
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                  child: Text(widget.phoneNumber,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontFamily: "Montserrat")))),
          const SizedBox(height: 20),
          const Text("Registration", style: TextStyle(fontSize: 16,color: Colors.white60)),
          const SizedBox(height: 5),
          Text(
            widget.registration,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Membership",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Center(
                child: widget.pendingMassage == 0
                    ? const Text("Inactive",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red))
                    : const Text("Active",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green)),
              )),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Package:",
                        style: TextStyle(color: Colors.white)),
                    Text(widget.amount.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )),
                    const Text("Massages:",
                        style: TextStyle(color: Colors.white)),
                    Text(widget.massages.toString(),
                        style: const TextStyle(
                            fontSize: 22, color: Colors.white)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pending Rs. ",
                        style: TextStyle(color: Colors.white)),
                    Text(widget.pendingAmount.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )),
                    const Text("Massages Left: ",
                        style: TextStyle(color: Colors.white)),
                    Text(widget.pendingMassage.toString(),
                        style: const TextStyle(
                            fontSize: 22, color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton(
            color: CupertinoColors.systemGreen,
            onPressed: () {
              if (widget.pendingMassage == 0) {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text("Membership Expired",
                              style: TextStyle(color: Colors.red)),
                          content: const Text(
                              "Please pay at reception to continue enjoy our services"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Ok"))
                          ],
                        ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookSession(pendingMassages: widget.pendingMassage),
                    ));
              }
            },
            child: const Text("Book Session"),
          ),
        ],
      ),
    );
  }
}
