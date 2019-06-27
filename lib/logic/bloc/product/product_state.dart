import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:my_flutter_course/logic/logic.dart';

@immutable
abstract class ProductState extends Equatable {
  ProductState([List props = const []]) : super(props);
}

class ProductUninitialized extends ProductState {
  @override
  String toString() => 'Product Uninitialized';
}

class ProductLoading extends ProductState {
  @override
  String toString() => 'Product Loading';
}


class ProductError extends ProductState {
  ProductError(this.error) : super([error]);

  final Exception error;
  @override
  String toString() => 'Product Error';
}

class ProductReady extends ProductState {
  ProductReady({
    @required this.products,
    this.selectedId,
  }) : super([...products, selectedId]);

  final List<Product> products;
  final String selectedId;

  Product selectedProduct() {
    return products.firstWhere((p) => p.id == selectedId);
  }

  
  @override
  String toString() {
    return 'Product Ready ${products.length}, selectedId: $selectedId';
  }
}
