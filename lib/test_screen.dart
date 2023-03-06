import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("some title"),
        ),
        body: Center(
          child: Text("hhh"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Column(children: [
                Icon(Icons.account_circle),
                SizedBox(
                  width: 100,
                  height: 5,
                ),
                Text("this is a drawer")
              ])),
              Material(
                child: ListTile(
                  title: Text("option 1"),
                  onTap: () {
                    print("this is awsome");
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text("Create a transaction"),
                        content: Text("some content"),
                        actions: <Widget>[
                          Text("erer")
                        ],
                        elevation: 10,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
