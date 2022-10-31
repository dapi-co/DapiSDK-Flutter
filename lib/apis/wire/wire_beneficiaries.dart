import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiWireBeneficiariesResponse? state;
String? error;

class WireBeneficiaries extends StatefulWidget {
  const WireBeneficiaries({super.key});

  @override
  State<StatefulWidget> createState() {
    return WireBeneficiariesState();
  }
}

class WireBeneficiariesState extends State<WireBeneficiaries> {
  Future<DapiWireBeneficiariesResponse?> getWireBeneficiaries(
      DapiConnection connection) async {
    try {
      DapiWireBeneficiariesResponse beneficiariesResponse =
          await connection.getWireBeneficiaries();
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
    getWireBeneficiaries(selectedConnection!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wire Beneficiaries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state == null
                ? [const CircularProgressIndicator()]
                : [
                    Expanded(
                        child: ListView.builder(
                            itemCount: state?.beneficiaries?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DataListItem(
                                  topLeft: state?.beneficiaries?[index].name,
                                  topRight: state?.beneficiaries?[index].type,
                                  bottomLeft: state
                                      ?.beneficiaries?[index].routingNumber,
                                  bottomRight:
                                      "***${state?.beneficiaries?[index].accountNumber?.substring(state!.beneficiaries![index].accountNumber!.length - 4)}");
                            }))
                  ]),
      ),
    );
  }
}
