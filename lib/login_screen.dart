import 'dart:convert';

import 'package:bankly_flutter/config.dart';
import 'package:bankly_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String userName = '';
  String password='';
  String error='';
  BuildContext? mContext;

  Future<void> login() async {
    print('trying to login');
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$API_URL/auth/login'));
    request.body = json.encode({
      "email": userName,
      "password": password,
      "role": "CLIENT"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 202) {
      String jsonText=await response.stream.bytesToString();
      JWT_TOKEN=jsonDecode(jsonText)['jwtToken'];
      print("token updated to $JWT_TOKEN");
      if(mContext!=null && Navigator.canPop(mContext!)){
        Navigator.pop(mContext!);
      }
      Navigator.push(mContext!, MaterialPageRoute(builder: (context)=> MainScreen()));
    }
    else {
      print(response.reasonPhrase);
      setState(() {
        error="Invalid user name or password";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    this.mContext=context;
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to BANKLY",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent,fontSize: 30))
                ,
                SizedBox(width:100,height:50),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "user name"),
                  autofocus: true,
                  onChanged: (text) {
                    userName = text;
                  },
                ),
                SizedBox(width:100,height:10)
              ,
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "*******"),
                  autofocus: true,
                  onChanged: (text) {
                    password = text;
                  },
                ),
                SizedBox(width:100,height:10),
                SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(onPressed: login, child: Text("Login"))),
                Text(error,style: TextStyle(color:Colors.red),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
