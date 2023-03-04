import 'package:flutter/material.dart';


class ClientAdd extends StatefulWidget {
  const ClientAdd({Key? key}) : super(key: key);

  @override
  State<ClientAdd> createState() => _ClientAddState();
}

class _ClientAddState extends State<ClientAdd> {
  final nameController = TextEditingController();
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Flexible(child: Image.asset("assets/logo.png")),
        Form(
          key: nameKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                  filled: true,
                  hintText: "Name",
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
      ]),
    );
  }
}
