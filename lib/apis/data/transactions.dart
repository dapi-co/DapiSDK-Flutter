import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiTransactionsResponse? state;
String? error;

class Transactions extends StatefulWidget {
  final bool isAccountTransactions;

  const Transactions({super.key, required this.isAccountTransactions});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TransactionsState(isAccountTransactions: isAccountTransactions);
  }
}

class TransactionsState extends State<Transactions> {
  final bool isAccountTransactions;

  TransactionsState({required this.isAccountTransactions});

  Future<DapiTransactionsResponse?> getTransactionsForAccount(
      DapiConnection connection, DateTime fromDate, DateTime toDate) async {
    try {
      DapiAccount account = await connection.presentAccountSelection();
      DapiTransactionsResponse transactionsResponse =
          await connection.getTransactionsForAccount(
              account,
              fromDate,
              toDate,
              type: DapiTransactionsType.DEFAULT);
      setState(() {
        state = transactionsResponse;
      });
      return transactionsResponse;
    } on DapiSdkException catch (e) {
      error = e.message;
      var snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  Future<DapiTransactionsResponse?> getTransactionsForCard(
      DapiConnection connection, DateTime fromDate, DateTime toDate) async {
    try {
      DapiCardsResponse cardsResponse = await connection.getCards();
      DapiTransactionsResponse transactionsResponse = await connection
          .getTransactionsForCard(cardsResponse.cards!.first, fromDate, toDate,
              type: DapiTransactionsType.DEFAULT);
      setState(() {
        state = transactionsResponse;
      });
      return transactionsResponse;
    } on DapiSdkException catch (e) {
      error = e.message;
      var snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (isAccountTransactions) {
      getTransactionsForAccount(selectedConnection!, DateTime.parse("2022-05-01"),
          DateTime.parse("2022-09-10"));
    } else {
      getTransactionsForCard(selectedConnection!, DateTime.parse("2022-05-01"),
          DateTime.parse("2022-09-10"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state == null
                ? [const Center(child: CircularProgressIndicator())]
                : [
                    Expanded(
                        child: ListView.builder(
                            itemCount: state?.transactions?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DataListItem(
                                  topLeft: state?.transactions?[index].date
                                      ?.toIso8601String(),
                                  topRight:
                                      "${state?.transactions?[index].currency?.code} ${state?.transactions?[index].amount}",
                                  bottomLeft:
                                      state?.transactions?[index].description,
                                  bottomRight:
                                      state?.transactions?[index].type);
                            }))
                  ]),
      ),
    );
  }
}
