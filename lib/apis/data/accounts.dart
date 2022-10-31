import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiAccountsResponse? state;
String? error;
class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<StatefulWidget> createState() {
    return AccountsState();
  }
}

class AccountsState extends State<Accounts> {
  Future<DapiAccountsResponse?> getAccounts(DapiConnection connection) async {
    try {
      DapiAccountsResponse accountsResponse = await connection.getAccounts();
      setState(() {
        state = accountsResponse;
      });
      return accountsResponse;
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
    getAccounts(selectedConnection!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
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
                            itemCount: state?.accounts?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DataListItem(
                                  topLeft: state?.accounts?[index].name,
                                  topRight:
                                      "${state?.accounts?[index].currency?.code} ${state?.accounts?[index].balance}",
                                  bottomLeft:
                                      "${state?.accounts?[index].iban?.substring(0, 12)} ***",
                                  bottomRight:
                                      "***${state?.accounts?[index].number?.substring(state!.accounts![index].number!.length - 4)}");
                            }))
                  ]),
      ),
    );
  }
}
