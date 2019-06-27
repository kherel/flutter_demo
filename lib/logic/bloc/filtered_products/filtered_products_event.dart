import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:my_flutter_course/logic/logic.dart';

@immutable
abstract class FilteredPEvent extends Equatable {
  FilteredPEvent([List props = const []]) : super(props);
}

class UpdateFavFilter extends FilteredPEvent {
  UpdateFavFilter({this.isOnlyFavorite}) : super([isOnlyFavorite]);

  final bool isOnlyFavorite;

  @override
  String toString() => 'Update favorite filter, '
      '${isOnlyFavorite ? "only favorites" : "all"}';
}

class UpdateFiteredProducts extends FilteredPEvent {
  UpdateFiteredProducts(this.products) : super([products]);

  final List<Product> products;

  @override
  String toString() => 'Update products fav products: total:${products.length}';
}
