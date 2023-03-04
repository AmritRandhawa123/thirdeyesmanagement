
import 'package:flutter/material.dart';

class Alerts{
  String content;
  String title;
  BuildContext context;


  Alerts(this.content, this.title, this.context);

  void show(){

      showDialog(context: context, builder: (context) => _alert(),barrierDismissible: false);

  }

  Widget _alert(){
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Ok"))
      ],
    );
  }

}