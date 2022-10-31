import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

DapiIdentityResponse? state;
String? error;
class Identity extends StatefulWidget {
  const Identity({super.key});

  @override
  State<StatefulWidget> createState() {
    return IdentityState();
  }
}

class IdentityState extends State<Identity> {
  Future<DapiIdentityResponse?> getIdentity(DapiConnection connection) async {
    try {
      DapiIdentityResponse identityResponse = await connection.getIdentity();
      setState(() {
        state = identityResponse;
      });
      return identityResponse;
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
    getIdentity(selectedConnection!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state == null
                ? [const Center(child: CircularProgressIndicator())]
                : [
              Text("Nationality: ${state?.identity?.nationality}"),
              Text("DateOfBirth: ${state?.identity?.dateOfBirth}"),
              Text("EmailAddress: ${state?.identity?.emailAddress}"),
              Text("Name: ${state?.identity?.name}"),
              Text("Address flat: ${state?.identity?.address?.flat}"),
              Text("Address building: ${state?.identity?.address?.building}"),
              Text("Address area: ${state?.identity?.address?.area}"),
              Text("Address poBox: ${state?.identity?.address?.poBox}"),
              Text("Address city: ${state?.identity?.address?.city}"),
              Text("Address state: ${state?.identity?.address?.state}"),
              Text("Address country: ${state?.identity?.address?.country}"),
              Text("Address full: ${state?.identity?.address?.full}"),
              const Text("More in the console..."),
            ]),
      ),
    );
  }
}
