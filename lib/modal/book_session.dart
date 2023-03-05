import 'package:flutter/material.dart';

class BookSession extends StatefulWidget {
  const BookSession({Key? key}) : super(key: key);

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: const [
        Text("data")
      ],
    ),);
  }
}
