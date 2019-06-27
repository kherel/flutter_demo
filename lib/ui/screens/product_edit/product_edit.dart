import 'package:flutter/material.dart';
import 'package:my_flutter_course/ui/components/components.dart';
import 'package:my_flutter_course/logic/logic.dart';

class ProductEdit extends StatelessWidget {
  static const String routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final _productBloc = BlocProvider.of<ProductBloc>(context);
    assert(_productBloc.currentState is ProductReady, 'wronge state');

    final products = (_productBloc.currentState as ProductReady).products;
    final selectedId = (_productBloc.currentState as ProductReady).selectedId;

    onSubmit({
      title,
      description,
      image,
      price,
    }) {
      _productBloc.dispatch(EditProduct(
        title: title,
        description: description,
        image: image,
        price: price,
      ));
      Navigator.pop(context);
    }

    return ProductForm(
      product: products.firstWhere((p) => p.id == selectedId),
      isLoading: false,
      onSubmit: onSubmit,
    );
  }
}
