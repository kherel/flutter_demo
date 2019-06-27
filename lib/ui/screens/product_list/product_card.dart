import 'package:flutter/material.dart';

import 'package:my_flutter_course/logic/logic.dart';
import 'package:my_flutter_course/ui/screens/screens.dart';
import 'package:my_flutter_course/ui/components/components.dart';

import './address_tag.dart';
import './price_tag.dart';

@immutable
class ProductCard extends StatelessWidget {
  const ProductCard(this.product, this.productIndex);

  final Product product;
  final int productIndex;

  Widget _buildTitlePriceRow() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CTitle(product.title),
          const SizedBox(
            width: 8.0,
          ),
          PriceTag(product.price)
        ],
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final _productBloc = BlocProvider.of<ProductBloc>(context);

    return <Widget>[
      IconButton(
          icon: const Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () {
            _productBloc.dispatch(SelectProduct(product.id));
            Navigator.pushNamed(context, '${ProductShow.routeName}');
          }),
          
      IconButton(
        icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
        color: Colors.red,
        onPressed: () {
          _productBloc.dispatch(ToggleFavoriteProduct(product.id));
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            placeholder: const AssetImage('assets/images/food.jpg'),
            height: 280,
            fit: BoxFit.cover,
          ),
          _buildTitlePriceRow(),
          const AddressTag('Union Square, San Francisco'),
          Text(product.author.userEmail.toString()),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: _buildButtons(context),
          ),
        ],
      ),
    );
  }
}
