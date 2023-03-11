import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Test extends StatefulWidget {
  const Test({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  final PanelController _pc1 =  PanelController();
  final PanelController _pc2 =  PanelController();
  bool _visible = true;



  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: _visible,
            child: SlidingUpPanel(
              controller: _pc1,
              panel: Center(
                child: TextButton(
                  child: Text('Show new panel 2'),
                  onPressed: () {
                    _pc1.close();
                    _visible = false;
                    setState(() {});
                    _pc2.open();
                  },
                ),
              ),
              collapsed: Container(
                decoration:
                BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
                child: Center(
                  child: Text(
                    "Panel 1",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
              body: Center(
                  child: Text(
                      "Panel 1 This is the Widget behind the sliding panel")),
              borderRadius: radius,
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: !_visible,
            child: SlidingUpPanel(
              controller: _pc2,
              panel: Center(
                child: TextButton(
                  child: Text('Show new panel 1'),
                  onPressed: () {
                    _pc2.close();
                    _visible = true;
                    setState(() {});
                    _pc1.open();
                  },
                ),
              ),
              collapsed: Container(
                decoration:
                BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
                child: Center(
                  child: Text(
                    "Panel 2 ",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              body: Center(
                child:
                Text("Panel 2 This is the Widget behind the sliding panel"),
              ),
              borderRadius: radius,
            ),
          ),
        ],
      ),
    );
  }
}