import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool visible;

  const Button(
      {super.key, required this.onPressed, required this.text, this.visible = true});

  @override
  Widget build(BuildContext context) {
    Widget button = Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
    return Visibility(child: button, visible: visible);
  }
}

class DataListItem extends StatelessWidget {
  final String? topLeft;
  final String? topRight;
  final String? bottomLeft;
  final String? bottomRight;

  const DataListItem(
      {super.key, required this.topLeft,
      required this.topRight,
      required this.bottomLeft,
      required this.bottomRight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(topLeft == null ? "NA" : topLeft!),
                  Text(topRight == null ? "NA" : topRight!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(bottomLeft == null ? "NA" : bottomLeft!),
                  Text(bottomRight == null ? "NA" : bottomRight!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
