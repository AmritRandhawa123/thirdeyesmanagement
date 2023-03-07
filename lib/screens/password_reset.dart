import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  var emailController = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  bool loading = false;
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.arrow_back),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ))
              ],
            ),
          ),
          Flexible(child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset("assets/slider3.png"),
          )),
          Form(
            key: _emailKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your email";
                  } else if (!EmailValidator.validate(
                      emailController.value.text)) {
                    return "Email invalid";
                  } else {
                    return null;
                  }
                },
                showCursor: true,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: Colors.redAccent, size: 20),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
                "We will send you a reset link on you registered email id to recover your account.",
                softWrap: true,
                style:
                    TextStyle(fontFamily: "Montserrat", color: Colors.black54)),
          ),
          loading
              ? const CircularProgressIndicator(
                  color: Colors.blueAccent,
                )
              : Container(
                  height: 20,
                ),
          done
              ? CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: (const Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  )),
                )
              : CupertinoButton(
                  color: Colors.blueAccent,
                  onPressed: loading
                      ? null
                      : () {
                          if (_emailKey.currentState!.validate()) {
                            _validation();
                          }
                        },
                  child: const Text("Send Reset Link"))
        ],
      )),
    );
  }

  void _validation() async {
    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.value.text)
          .then((value) => {proceed()});
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      if (e.code == 'user-not-found') {
        error("User Not Found",
            "Your account is not registered with us do you still have query? Contact Admin.");
      } else if (e.code == 'user-disabled') {
        error("User Account is disabled",
            "Your account is disabled by admin please contact for more information.");
      } else if (e.code == "too-many-requests") {
        error("Limit Exceed",
            "Try again later you have exceed the numbers of limit");
      } else {
        error("Something went wrong",
            "Check internet connectivity or try again later");
      }
    }
  }

  void proceed() {
    setState(() {
      loading = false;
      done = true;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Reset link as been Sent")));
  }

  Future error(String title, String description) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("OK"),
                    )),
              ],
            ));
  }
}
