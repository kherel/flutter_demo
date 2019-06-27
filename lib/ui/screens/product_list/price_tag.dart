import 'package:flutter/material.dart';
import 'package:my_flutter_course/logic/logic.dart';

class PriceTag extends StatelessWidget {
  const PriceTag(this.price);

  final Price price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        price.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
