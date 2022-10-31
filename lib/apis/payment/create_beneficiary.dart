import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiResult? state;
String? error;
class CreateBeneficiary extends StatefulWidget {
  const CreateBeneficiary({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreateBeneficiaryState();
  }
}

class CreateBeneficiaryState extends State<CreateBeneficiary> {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController swiftCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();

  Future<DapiResult?> createBeneficiary(DapiBeneficiary beneficiary) async {
    try {
      DapiResult result = await selectedConnection!.createBeneficiary(beneficiary);
      setState(() {
        state = result;
      });
      var snackBar = const SnackBar(content: Text("Added the beneficiary successfully."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return result;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Beneficiary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: accountNumberController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Account Number',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: ibanController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'IBAN',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: bankNameController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Bank Name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: swiftCodeController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Swift Code',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: countryController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Country',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: branchAddressController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Branch Address',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: branchNameController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Branch Name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: phoneNumberController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Numberr',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: nicknameController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nickname',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: addressLine1Controller,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address Line 1',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: addressLine2Controller,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address Line 2',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: addressLine3Controller,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address Line 3',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                Button(
                    onPressed: () => {
                          createBeneficiary(DapiBeneficiary(
                              address: DapiLineAddress(
                                line1: addressLine1Controller.text,
                                line2: addressLine2Controller.text,
                                line3: addressLine3Controller.text,
                              ),
                              accountNumber: accountNumberController.text,
                              name: nameController.text,
                              bankName: bankNameController.text,
                              swiftCode: swiftCodeController.text,
                              iban: ibanController.text,
                              phoneNumber: phoneNumberController.text,
                              country: countryController.text,
                              branchAddress: branchAddressController.text,
                              branchName: branchNameController.text))
                        },
                    text: "Confirm"),
              ]),
        ),
      ),
    );
  }
}
