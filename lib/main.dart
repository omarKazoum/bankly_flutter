import 'dart:convert';

import 'package:bankly_flutter/make_transaction_widget.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';

import 'login_screen.dart';
import 'package:flutter/material.dart';

import 'transaction.dart';

/*
void main() {
  runApp(const MyApp());
}
*/

// function to trigger build process
void main() {
  runApp(MaterialApp(home: LoginScreen()));


}
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}
class _MainScreenState extends State<MainScreen>{

  @override
    Widget build(BuildContext context) {
      List<Transaction> list = [];
      for (int i = 0; i < 10; i++) {
        list.add(Transaction(
            accountId: 'BGRZ987$i',
            amount: 100 * (i + 1),
            createdAt: 'Mon ${i + 1} march',
            id: "TR$i",
            type:
            i.isEven ? TransactionType.WITHDRAWAL : TransactionType.DEPOSIT));
      }
      TextStyle balanceStyle =
      new TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold);


      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.blueAccent,
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              title: const Text("BANKLY"),
            ), // AppBar
            body: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            const Center(
                                child: Icon(
                                  Icons.account_circle,
                                  size: 75,
                                )),
                            const SizedBox(width: 1, height: 2),
                            const Text("User name"),
                            const SizedBox(width: 1, height: 10),
                            const Text("user@email.com"),
                            const SizedBox(width: 1, height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Your Balance:", style: balanceStyle),
                                  Text("20 USD", style: balanceStyle)
                                ]),
                          ],
                        )),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: const Text(
                                  "Operations:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ListView(
                                  children: list
                                      .map((t) => TransactionItem(
                                      transaction: Transaction(
                                          accountId: t.accountId,
                                          amount: t.amount,
                                          createdAt: t.createdAt,
                                          id: t.id,
                                          type: t.type)))
                                      .toList(),
                                ),
                              )
                            ],
                          )),
                    )),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.push(context!, MaterialPageRoute(builder: (context)=> MakeTransactionWidget(transactionType:TransactionType.WITHDRAWAL )));

                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white)),
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(children: [
                              Icon(
                                Icons.monetization_on_rounded,
                                color: Colors.green,
                              ),
                              Text(
                                "Withdraw",
                                style: TextStyle(color: Colors.black),
                              ),
                            ])),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white)),
                        onPressed: () {


                          Navigator.push(context!, MaterialPageRoute(builder: (context)=> MakeTransactionWidget(transactionType:TransactionType.DEPOSIT )));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(children: [
                            Icon(
                              Icons.add_box_rounded,
                              color: Colors.green,
                            ),
                            Text(
                              "Deposit",
                              style: TextStyle(color: Colors.black),
                            ),
                          ]),
                        ),
                      ),
                    )
                  ],
                )
              ], // Center
            ),
            // Container
          ) // Scaffold

      );
    }




}
