import 'package:flutter/material.dart';
import 'package:my_flutter_course/logic/logic.dart';

import 'package:my_flutter_course/ui/components/components.dart';

class ProductShow extends StatefulWidget {
  static const String routeName = '/show';

  @override
  _ProductShowState createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
  ProductBloc _productBloc;
  
  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _productBloc,
      builder: (context, state) {
        var product = state.selectedProduct() ;
        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(product.image),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: CTitle(product.title),
              ),
              _buildAddressPriceRow(product.price),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressPriceRow(Price price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Francisco',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '${price.toString()}',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }
}
