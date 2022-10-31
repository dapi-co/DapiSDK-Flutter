import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

DapiAccountsMetadataResponse? state;
String? error;

class Metadata extends StatefulWidget {
  const Metadata({super.key});

  @override
  State<StatefulWidget> createState() {
    return MetadataState();
  }
}

class MetadataState extends State<Metadata> {
  Future<DapiAccountsMetadataResponse?> getAccountsMetadata(
      DapiConnection connection) async {
    try {
      DapiAccountsMetadataResponse accountsMetadataResponse =
          await connection.getAccountsMetadata();
      setState(() {
        state = accountsMetadataResponse;
      });
      return accountsMetadataResponse;
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
    getAccountsMetadata(selectedConnection!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metadata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state == null
                ? [const Center(child: CircularProgressIndicator())]
                : [
                    Text("BankName: ${state?.metadata?.bankName}"),
                    Text(
                        "BeneficiaryCoolDownPeriod Unit: ${state?.metadata?.beneficiaryCoolDownPeriod?.unit}"),
                    Text(
                        "BeneficiaryCoolDownPeriod Value: ${state?.metadata?.beneficiaryCoolDownPeriod?.value}"),
                    Text("BranchAddress: ${state?.metadata?.branchAddress}"),
                    Text("BranchName: ${state?.metadata?.branchName}"),
                    Text("Country Name ${state?.metadata?.country?.name}"),
                    Text("Country Code ${state?.metadata?.country?.code}"),
                    Text(
                        "IsCreateBeneficiaryEndpointRequired: ${state?.metadata?.isCreateBeneficiaryEndpointRequired}"),
                    Text("SortCode: ${state?.metadata?.sortCode}"),
                    Text("SwiftCode: ${state?.metadata?.swiftCode}"),
                    Text(
                        "TransactionRange Unit: ${state?.metadata?.transactionRange?.unit}"),
                    Text(
                        "TransactionRange Value: ${state?.metadata?.transactionRange?.value}"),
                    Text(
                        "WillNewlyAddedBeneficiaryExistBeforeCoolDownPeriod: ${state?.metadata?.willNewlyAddedBeneficiaryExistBeforeCoolDownPeriod}"),
                    const Text("More in the console..."),
                  ]),
      ),
    );
  }
}
