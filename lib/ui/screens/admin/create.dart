import 'package:flutter/material.dart';
import 'package:my_flutter_course/ui/components/components.dart';
import 'package:my_flutter_course/logic/logic.dart';

class ProductCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductCreateState();
  }
}

class ProductCreateState extends State<ProductCreate> {
  @override
  Widget build(BuildContext context) {
    final _productBloc = BlocProvider.of<ProductBloc>(context);

    return BlocBuilder(
      bloc: _productBloc,
      builder: (context, productState) {
        final isLoading = _productBloc.state == ProductLoading();
        onSubmit({
          title,
          description,
          image,
          price,
        }) =>
            _productBloc.dispatch(CreateProduct(
              title: title,
              description: description,
              image: image,
              price: price,
            ));

        return ProductForm(
          isLoading: isLoading,
          onSubmit: onSubmit,
        );
      },
    );
  }
}
