import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiBeneficiariesResponse? state;
String? error;

class Beneficiaries extends StatefulWidget {
  const Beneficiaries({super.key});

  @override
  State<StatefulWidget> createState() {
    return BeneficiariesState();
  }
}

class BeneficiariesState extends State<Beneficiaries> {
  Future<DapiBeneficiariesResponse?> getBeneficiaries(
      DapiConnection connection) async {
    try {
      DapiBeneficiariesResponse beneficiariesResponse =
      await connection.getBeneficiaries();
      setState(() {
        state = beneficiariesResponse;
      });
      return beneficiariesResponse;
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
    getBeneficiaries(selectedConnection!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beneficiaries'),
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
                            itemCount: state?.beneficiaries?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DataListItem(
                                  topLeft: state?.beneficiaries?[index].name,
                                  topRight: state?.beneficiaries?[index].type,
                                  bottomLeft:
                                      "${state?.beneficiaries?[index].iban?.substring(0, 12)} ***",
                                  bottomRight:
                                      "***${state?.beneficiaries?[index].accountNumber?.substring(state!.beneficiaries![index].accountNumber!.length - 4)}");
                            }))
                  ]),
      ),
    );
  }
}
