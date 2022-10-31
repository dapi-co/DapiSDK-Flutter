import 'package:dapi/dapi.dart';

DapiConnection? selectedConnection;

DapiBeneficiary beneficiary() {
  DapiLineAddress lineAddress = DapiLineAddress(
      line1: "baniyas road", line2: "dubai", line3: "united arab emirates");

  return DapiBeneficiary(
      address: lineAddress,
      accountNumber: "1647518280840289401662",
      name: "name",
      bankName: "bankName",
      swiftCode: "DAPIBANK",
      iban: "DAPIBANKAEHSBC1647518280840289401662",
      country: "AE",
      branchAddress: "branchAddress",
      branchName: "branchName",
      phoneNumber: "xxxxxxxxxxx");
}

DapiWireBeneficiary wireBeneficiary() {
  DapiLineAddress lineAddress = DapiLineAddress(
      line1: "2400 bruce street UCA stadium park bld 6", line2: "", line3: "");

  return DapiWireBeneficiary(
      address: lineAddress,
      accountNumber: "1234567654321",
      name: "TestAccount",
      country: "US",
      receiverType: "retail",
      routingNumber: "953349354",
      nickname: "OmarChase",
      receiverAccountType: "checking",
      firstName: "Omar",
      lastName: "Agoor",
      zipCode: "72305",
      state: "Arkansas",
      city: "Conway");
}