import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class Price extends Equatable {
  Price(this.perItem);

  final double perItem;

  @override
  String toString() {
    return '\$ ${(perItem * 100).roundToDouble() / 100}';
  }

  double toJson() {
    return perItem;
  }
}
