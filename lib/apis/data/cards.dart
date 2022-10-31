import 'package:dapi/dapi.dart';
import 'package:dapisdk_flutter/common/global.dart';
import 'package:flutter/material.dart';

import '../../common/components.dart';

DapiCardsResponse? state;
String? error;
class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<StatefulWidget> createState() {
    return CardsState();
  }
}

class CardsState extends State<Cards> {

  Future<DapiCardsResponse?> getCards(DapiConnection connection) async {
    try {
      DapiCardsResponse cardsResponse = await connection.getCards();
      setState(() {
        state = cardsResponse;
      });
      return cardsResponse;
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
    getCards(selectedConnection!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
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
                      itemCount: state?.cards?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DataListItem(
                            topLeft: state?.cards?[index].name,
                            topRight:
                            "${state?.cards?[index].currency?.code} ${state?.cards?[index].balance?.availableBalance}",
                            bottomLeft: state?.cards?[index].status,
                            bottomRight:
                            "***${state?.cards?[index].cardNumber?.substring(state!.cards![index].cardNumber!.length - 4)}");
                      }))
            ]),
      ),
    );
  }
}
