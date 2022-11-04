import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/apis/data/accounts.dart';
import 'package:dapisdk_flutter/apis/data/cards.dart';
import 'package:dapisdk_flutter/apis/data/identity.dart';
import 'package:dapisdk_flutter/apis/data/transactions.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Identity()),
                        )
                      },
                  text: "Identity"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Accounts()),
                        )
                      },
                  text: "Accounts"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cards()),
                        )
                      },
                  text: "Cards"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Transactions(
                                  isAccountTransactions: true)),
                        )
                      },
                  text: "Account Transactions"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Transactions(
                                  isAccountTransactions: false)),
                        )
                      },
                  text: "Card Transactions"),
            ]),
      ),
    );
  }
}
