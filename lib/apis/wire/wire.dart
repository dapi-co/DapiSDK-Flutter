import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/apis/wire/create_wire_beneficiary.dart';
import 'package:dapisdk_flutter/apis/wire/wire_beneficiaries.dart';
import 'package:flutter/material.dart';

import '../../common/global.dart';
import '../../common/components.dart';

class Wire extends StatelessWidget {
  const Wire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(
                  onPressed: () => {createWireTransfer(selectedConnection!)},
                  text: "Wire Payment Using Dapi UI"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateWireBeneficiary()),
                        )
                      },
                  text: "Create Wire Beneficiary"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WireBeneficiaries()),
                        )
                      },
                  text: "Get Wire Beneficiaries"),
            ]),
      ),
    );
  }
}

Future<CreateTransferResponse?> createWireTransfer(
    DapiConnection connection) async {
  try {
    Dapi.onTransferUiDismissed.listen((m) => print("TRANSFER_UI_DISMISSED"));
    CreateTransferResponse result = await connection.createWireTransfer(
        null, wireBeneficiary(), 100, null);
    // print(result.accountID);
    return result;
  } on DapiSdkException catch (e) {
    print('Error logged in Example Flutter app $e.');
  }
  return null;
}
