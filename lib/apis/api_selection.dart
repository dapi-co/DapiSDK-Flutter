import 'package:dapisdk_flutter/apis/data/data.dart';
import 'package:dapisdk_flutter/apis/metadata/metadata.dart';
import 'package:dapisdk_flutter/apis/payment/payment.dart';
import 'package:dapisdk_flutter/apis/wire/wire.dart';
import 'package:flutter/material.dart';

import '../common/components.dart';

class ApiSelection extends StatelessWidget {
  const ApiSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Data()),
                        )
                      },
                  text: "Data"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Metadata()),
                        )
                      },
                  text: "Metadata"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Payment()),
                        )
                      },
                  text: "Payment"),
              Button(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Wire()),
                        )
                      },
                  text: "Wire (US Only)"),
            ]),
      ),
    );
  }
}
