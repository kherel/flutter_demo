import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:my_flutter_course/logic/logic.dart';

@immutable
abstract class FilteredPState extends Equatable {
  FilteredPState([List props = const []]) : super(props);
}

class FilteredPLoading extends FilteredPState {
  FilteredPLoading({this.isOnlyFavorite}) : super([isOnlyFavorite]);

  final bool isOnlyFavorite;

  @override
  String toString() => 'Filtered products loading';
}

class FilteredPReady extends FilteredPState {
  FilteredPReady(
    this.products, {
    this.isOnlyFavorite,
  }) : super([
          products,
          isOnlyFavorite,
        ]);

  final bool isOnlyFavorite;
  final List<Product> products;

  @override
  String toString() => 'Filtered products ready to use';
}
