import 'dart:convert';

import 'package:bankly_flutter/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'transaction.dart';

class MakeTransactionWidget extends StatefulWidget{
  TransactionType transactionType;

  MakeTransactionWidget({Key? key,required this.transactionType}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _MakeTransactionWidgetState(transactionType: transactionType);
  }


}
class _MakeTransactionWidgetState extends State<MakeTransactionWidget>{
  TransactionType transactionType;
  double amount=0;
  bool isLoading=false;
  String error='';
  _MakeTransactionWidgetState({required this.transactionType});

   addTransaction() async {
     setState(() {
       isLoading=true;
     });
    print("handling transaction");
    var headers = {
      'Authorization': 'Bearer $JWT_TOKEN'
    };
    var request = http.Request('GET', Uri.parse('$API_URL/wallet/${transactionType==TransactionType.DEPOSIT?'deposit':'withdraw'}?amount=$amount'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        setState(() {
          isLoading=false;
          error='';
        });
     }
     else {
      var er=jsonDecode(await response.stream.bytesToString())['message'];
      setState((){
        isLoading=false;
        error=er;
      });
     }

   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "title",
        home: Scaffold(
            backgroundColor: Colors.blueAccent,
            appBar: AppBar(
              title:  Text("make a ${getTransactionTypeAsString()}"),
            ), // AppBar
            body:  Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "amount ex: 100"),
                      autofocus: true,
                      onChanged: (amount) {
                        print("amount");
                        this.amount=double.parse(amount);
                      },
                    ),
                    SizedBox(width: 100,height: 10)
                    ,
                    SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: isLoading ?null:addTransaction, child: Text("make ${getTransactionTypeAsString()}"))),
                    SizedBox(width: 100,height: 10),
                    SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Go Back"))),
                    Text(error,style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          // Container
        ) // Scaffold

    );
  }
  getTransactionTypeAsString(){
    return "${transactionType==TransactionType.WITHDRAWAL?'Withdraw':'Deposit'}";
  }
}