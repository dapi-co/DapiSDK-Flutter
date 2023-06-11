import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/apis/payment/beneficiaries.dart';
import 'package:dapisdk_flutter/apis/payment/create_beneficiary.dart';
import 'package:flutter/material.dart';

import '../../common/global.dart';
import '../../common/components.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(
                  onPressed: () {
                    createTransfer(selectedConnection!);
                  },
                  text: "Payment Using Dapi UI"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateBenef()),
                        )
                      },
                  text: "Create Beneficiary"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Beneficiaries()),
                        )
                      },
                  text: "Get Beneficiaries")
            ]),
      ),
    );
  }
}

Future<CreateTransferResponse?> createTransfer(
    DapiConnection connection) async {
  try {
    Dapi.onTransferUiDismissed.listen((m) => print("TRANSFER_UI_DISMISSED"));

    CreateTransferResponse result =
        await connection.createTransfer(null, beneficiary(), 0, null);
    // print(result.accountID);
    // print(result.remark);
    // print(result.reference);
    // ...
    return result;
  } on DapiSdkException catch (e) {
    print('Error logged in Example Flutter app $e.');
  }
  return null;
}
