import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiConfigurations? state;
final hexReg = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

class Configurations extends StatefulWidget {
  const Configurations({super.key});

  @override
  State<StatefulWidget> createState() {
    return ConfigurationsState();
  }
}

class ConfigurationsState extends State<Configurations> {
  bool? isSandboxChecked = state?.environment == DapiEnvironment.SANDBOX;
  bool? isShowLogosChecked = state?.showLogos ?? true;
  bool? isShowExperimentalBanksChecked = state?.showExperimentalBanks ?? false;
  bool? isShowCloseButtonChecked = state?.showCloseButton ?? true;
  bool? isShowAddButtonChecked = state?.showAddButton ?? false;
  bool? isShowTransferSuccessfulResultChecked = state?.showTransferSuccessfulResult ?? true;
  bool? isShowTransferErrorResultChecked = state?.showTransferErrorResult ?? true;
  TextEditingController? lightPrimaryColor = TextEditingController(text: state?.theme?.primaryColor?.lightMode);
  TextEditingController? darkPrimaryColor = TextEditingController(text: state?.theme?.primaryColor?.darkMode);
  TextEditingController? language = TextEditingController(text: state?.language.toString().split('.').last.toLowerCase());
  TextEditingController theme = TextEditingController(text: state?.theme?.enforceTheme.toString().split('.').last.toLowerCase());

  Future<DapiConfigurations> getConfigurations() async {
    DapiConfigurations configurations = await Dapi.configurations();
    setState(() {
      state = configurations;
      isSandboxChecked = state?.environment == DapiEnvironment.SANDBOX;
      isShowLogosChecked = state?.showLogos ?? true;
      isShowExperimentalBanksChecked = state?.showExperimentalBanks ?? false;
      isShowCloseButtonChecked = state?.showCloseButton ?? true;
      isShowAddButtonChecked = state?.showAddButton ?? false;
      isShowTransferSuccessfulResultChecked = state?.showTransferSuccessfulResult ?? true;
      isShowTransferErrorResultChecked = state?.showTransferErrorResult ?? true;
      lightPrimaryColor = TextEditingController(text: state?.theme?.primaryColor?.lightMode);
      darkPrimaryColor = TextEditingController(text: state?.theme?.primaryColor?.darkMode);
      language = TextEditingController(text: state?.language.toString().split('.').last.toLowerCase());
      theme = TextEditingController(text: state?.theme?.enforceTheme.toString().split('.').last.toLowerCase());
    });
    return configurations;
  }

  @override
  void initState() {
    super.initState();
    getConfigurations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configurations'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Sandbox"),
                      value: isSandboxChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isSandboxChecked = newValue;
                        });
                        if (isSandboxChecked ?? true) {
                          state?.environment = DapiEnvironment.SANDBOX;
                        } else {
                          state?.environment =
                              DapiEnvironment.PRODUCTION;
                        }
                        Dapi.setConfigurations(state!);
                      }),
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Show Logos"),
                      value: isShowLogosChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isShowLogosChecked = newValue;
                        });
                        state?.showLogos = isShowLogosChecked;
                        Dapi.setConfigurations(state!);
                      }),
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Show Experimental Bank"),
                      value: isShowExperimentalBanksChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isShowExperimentalBanksChecked = newValue;
                        });
                        state?.showExperimentalBanks =
                            isShowExperimentalBanksChecked;
                        Dapi.setConfigurations(state!);
                      }),
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Show Close Button"),
                      value: isShowCloseButtonChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isShowCloseButtonChecked = newValue;
                        });
                        state?.showCloseButton =
                            isShowCloseButtonChecked;
                        Dapi.setConfigurations(state!);
                      }),
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Show Add Button"),
                      value: isShowAddButtonChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isShowAddButtonChecked = newValue;
                        });
                        state?.showAddButton = isShowAddButtonChecked;
                        Dapi.setConfigurations(state!);
                      }),
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Show Transfer Successful Result"),
                      value: isShowTransferSuccessfulResultChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isShowTransferSuccessfulResultChecked = newValue;
                        });
                        state?.showTransferSuccessfulResult =
                            isShowTransferSuccessfulResultChecked;
                        Dapi.setConfigurations(state!);
                      }),
                  CheckboxListTile(
                      tristate: false,
                      title: const Text("Show Transfer Error Result"),
                      value: isShowTransferErrorResultChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isShowTransferErrorResultChecked = newValue;
                        });
                        state?.showTransferErrorResult =
                            isShowTransferErrorResultChecked;
                        Dapi.setConfigurations(state!);
                      }),
                  TextField(
                    controller: theme,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Theme: LIGHT, DARK, DYNAMIC',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (newValue) {
                      if (newValue.toLowerCase() == "light") {
                        state?.theme?.enforceTheme = DapiTheme.LIGHT;
                      } else if (newValue.toLowerCase() == "dark") {
                        state?.theme?.enforceTheme = DapiTheme.DARK;
                      } else {
                        state?.theme?.enforceTheme = DapiTheme.DYNAMIC;
                      }
                      Dapi.setConfigurations(state!);
                    },
                  ),
                  TextField(
                    controller: lightPrimaryColor,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Light Primary Color #xxxxxx',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (newValue) {
                      if (hexReg.hasMatch(newValue)) {
                        state?.theme?.primaryColor?.lightMode =
                            newValue;
                        Dapi.setConfigurations(state!);
                      }
                    },
                  ),
                  TextField(
                    controller: darkPrimaryColor,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Dark Primary Color #xxxxxx',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (newValue) {
                      if (hexReg.hasMatch(newValue)) {
                        state?.theme?.primaryColor?.darkMode =
                            newValue;
                        Dapi.setConfigurations(state!);
                      }
                    },
                  ),
                  TextField(
                    controller: language,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Language: AR, EN',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (newValue) {
                      DapiLanguage language = DapiLanguage.EN;
                      if (newValue.toLowerCase() == "ar") {
                        language = DapiLanguage.AR;
                      } else {
                        language = DapiLanguage.EN;
                      }
                      state?.language = language;
                      Dapi.setConfigurations(state!);
                    },
                  ),
                ]),
          ),
        ));
  }
}
