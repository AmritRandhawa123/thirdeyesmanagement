import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:thirdeyesmanagement/modal/book_session.dart';

class ClientAdd extends StatefulWidget {
  const ClientAdd({Key? key}) : super(key: key);

  @override
  State<ClientAdd> createState() => _ClientAddState();
}

class _ClientAddState extends State<ClientAdd> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final amountController = TextEditingController();
  final massagesController = TextEditingController();
  final pendingAmountController = TextEditingController();
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> numberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> amountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> massagesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pendingAmountKey = GlobalKey<FormState>();
  double _age = 18;

  final _server = FirebaseFirestore.instance;

  bool loading = false;

  @override
  void dispose() {
    _server.terminate();
    nameController.dispose();
    numberController.dispose();
    amountController.dispose();
    massagesController.dispose();
    pendingAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffebf2ff),
      body: SingleChildScrollView(
        child: Column(children: [
          SafeArea(
              child: Stack(alignment: Alignment.center, children: [
            Expanded(
              child: Image.asset("assets/addForm.png",
                  height: MediaQuery.of(context).size.height / 4),
            ),
            loading ? const CircularProgressIndicator() : Container()
          ])),
          Form(
            key: nameKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't Empty";
                  } else if (value.length < 2) {
                    return "Incorrect Name";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    counterText: "",

                    filled: true,
                    hintText: "Client Name",
                    prefixIcon: const Icon(Icons.person,
                        color: Colors.black54, size: 20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ),
          Form(
            key: numberKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: numberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't Empty";
                  } else if (value.length < 10) {
                    return "Incorrect Number";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    counterText: "",

                    filled: true,
                    hintText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone,
                        color: Colors.black54, size: 20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Form(
                  key: amountKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't Empty";
                        } else {
                          return null;
                        }
                      },
                      maxLength: 5,
                      decoration: InputDecoration(
                          counterText: "",

                          filled: true,
                          hintText: "Package",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: massagesKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: massagesController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          counterText: "",
                          counter: null,
                          hintText: "Massages",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.always,
                activeTrackColor: Colors.lightGreen,
                inactiveTrackColor: Colors.black45,
                trackShape: const RectangularSliderTrackShape(),
                trackHeight: 8.0,
                thumbColor: Colors.blueGrey,
                valueIndicatorColor: Colors.teal,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child: Slider(
                value: _age,
                min: 18,
                max: 75,
                label: "${_age.round()} Age",
                activeColor: Colors.green,
                inactiveColor: Colors.black54,
                onChanged: (double value) {
                  setState(() {
                    _age = value;
                  });
                },
              )),
          Form(
            key: pendingAmountKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: pendingAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't Empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    counterText: "",

                    filled: true,
                    hintText: "Pending Amount",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ),
          CupertinoButton(
              color: CupertinoColors.activeGreen,
              onPressed: loading
                  ? null
                  : () {
                      if (nameKey.currentState!.validate() &
                          numberKey.currentState!.validate()) {
                        check();
                      }
                    },
              child: const Text("Create")),
          const SizedBox(
            height: 15,
          )
        ]),
      ),
    );
  }

  Future<void> _createDatabase() async {
    setState(() {
      loading = true;
    });
    _server
        .collection("clients")
        .doc(numberController.value.text)
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          loading = false;
        });
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Already Registered",style: TextStyle(color: Colors.green),),
                  content: const Text("Client is already registered with us."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text("Ok"))
                  ],
                ));
      } else {
        await FirebaseFirestore.instance.enableNetwork();
        Timestamp timestamp = Timestamp.now();
        _server
            .collection("clients")
            .doc(numberController.value.text.toString())
            .set({
          "name": nameController.value.text.toString().trim(),
          "age": _age.round().toInt(),
          "member" : true,
          "phone": numberController.value.text.toString(),
          "registration":
              DateFormat.yMMMd().add_jm().format(timestamp.toDate()),
          "amount": int.parse(amountController.value.text.toString()),
          "massages": int.parse(massagesController.value.text),
          "pendingAmount": int.parse(pendingAmountController.value.text),
          "pendingMassage": int.parse(massagesController.value.text),
          "pastServices": []
        }, SetOptions(merge: true)).then((value) => {
                  setState(() {
                    loading = false;
                  }),
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text("Package Created",style: TextStyle(color: Colors.green),),
                            content: const Text(
                                "Would like to Book Session? or Go Back?."),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                   Navigator.pop(ctx);
                                   Navigator.pop(context);

                                  },
                                  child: const Text("Go Back")),
                              TextButton(
                                  onPressed: () {
                                    // Navigator.of(ctx)
                                    //     .pushReplacement(MaterialPageRoute(
                                    //   builder: (context) => BookSession(
                                    //       number: numberController.value.text
                                    //           .toString(),
                                    //       clientName: nameController.value.text
                                    //           .toString(),
                                    //       pendingMassage: int.parse(
                                    //           pendingAmountController
                                    //               .value.text)),
                                    // ));
                                  },
                                  child: const Text("Book Session"))
                            ],
                          ))
                });
      }
    });
  }

  void check() {
    if (massagesKey.currentState!.validate() &
        amountKey.currentState!.validate() &
        pendingAmountKey.currentState!.validate()) {
      _createDatabase();
    }
  }


}
