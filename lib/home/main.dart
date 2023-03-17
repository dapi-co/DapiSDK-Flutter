import 'package:dapisdk_flutter/common/global.dart';
import 'package:dapisdk_flutter/home/configurations.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dapi/dapi.dart';

import '../apis/api_selection.dart';
import '../common/components.dart';

void main() {
  runApp(DapiApp());
}

class DapiApp extends StatefulWidget {
  @override
  _DapiAppState createState() => _DapiAppState();
}

class _DapiAppState extends State<DapiApp> {
  Future<List<DapiConnection>?>? _initFuture;
  List<DapiConnection> _connections = List.empty(growable: true);
  String? _error;

  Future<bool> _isStarted() async {
    try {
      bool isStarted = await Dapi.isStarted();
      return isStarted;
    } on DapiSdkException catch (e) {
      _error = e.message;
      var snackBar = SnackBar(content: Text(_error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return false;
  }

  Future<String?> _startDapi() async {
    try {
      bool isDapiStarted = await _isStarted();
      if (!isDapiStarted) {
        await Dapi.start("36d6cff54b48d0b81dc47ec5115a7bfaf65b15dce4086fa39d15341a125a39bd", "CLIENT_USER_ID",
            configurations: DapiConfigurations(
                environment: DapiEnvironment.SANDBOX,
                countries: List.from({"AE"}),
                postSuccessfulConnectionLoadingText: "Loading..",
                theme:
                    DapiThemeConfigurations(enforceTheme: DapiTheme.DYNAMIC)));
      }
    } on DapiSdkException catch (e) {
      _error = e.message;
      var snackBar = SnackBar(content: Text(_error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  Future<List<DapiConnection>?> _getConnections() async {
    try {
      bool isDapiStarted = await _isStarted();
      if (isDapiStarted) {
        List<DapiConnection> resultConnections = await Dapi.getConnections();
        setState(() {
          _connections = resultConnections;
        });
        return _connections;
      }
    } on DapiSdkException catch (e) {
      _error = e.message;
      var snackBar = SnackBar(content: Text(_error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  Future<List<DapiConnection>?> _init() async {
    await _startDapi();
    return await _getConnections();
  }

  void presentConnect() {
    Dapi.onConnectionSuccessful.listen((m) {
      _getConnections();
    });

    Dapi.onConnectionFailure.listen((m) {
      _error = m.error;
      var snackBar = SnackBar(content: Text(_error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    Dapi.onConnectDismissed.listen((m) => print("CONNECT_DISMISSED"));

    Dapi.presentConnect();
  }

  @override
  void initState() {
    _initFuture = _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dapi Connect"),
        ),
        body: FutureBuilder(
            future: _initFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Your current connections:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18)),
                    ),
                    if (_connections.isEmpty)
                      const Align(
                        alignment: Alignment.center,
                        child: Text("Connect your bank account to see it here.",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 16)),
                      )
                    else
                      Expanded(
                          child: ListView.builder(
                              itemCount: _connections.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedConnection =
                                            _connections[index];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ApiSelection()),
                                        );
                                      },
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    child: Image.network(
                                                        _connections[index]
                                                            .miniLogo)),
                                              ),
                                              Text(
                                                  _connections[index]
                                                      .bankShortName,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ));
                              })),
                    Button(
                        onPressed: () => presentConnect(),
                        text: "Connect With Dapi"),
                    Button(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Configurations()),
                            ),
                        text: "Edit Configurations")
                  ],
                ),
              );
            }),
      ),
    );
  }
}
