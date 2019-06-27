import 'package:flutter/material.dart';

import 'package:my_flutter_course/logic/logic.dart';

import './product_card.dart';

class ProductsList extends StatefulWidget {
  static const String routeName = '/list';

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  FilteredProductsBloc _filteredPBloc;

  @override
  void initState() {
    var _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.dispatch(FetchProducts());
    _filteredPBloc = FilteredProductsBloc(
      productBloc: _productBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _filteredPBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _filteredPBloc,
      builder: (context, filteredPState) {
        final _isOnlyFavorite = filteredPState.isOnlyFavorite;

        return Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: const Text('EasyList'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  _isOnlyFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  _filteredPBloc.dispatch(UpdateFavFilter(
                    isOnlyFavorite: !_isOnlyFavorite,
                  ));
                },
              )
            ],
          ),
          body: _buildScaffoldBody(filteredPState),
        );
      },
    );
  }

  Widget _buildScaffoldBody(filteredPState) {
    Widget _result;
    switch (filteredPState.runtimeType) {
      case FilteredPLoading:
        _result = const Center(child: CircularProgressIndicator());
        break;
      case FilteredPReady:
        _result = _buildProductsScreen(filteredPState.products);
        break;
    }
    return _result;
  }

  Widget _buildProductsScreen(products) {

    if (products.isEmpty) {
      return const Center(child: Text('no products'));
    } else {
      return ListView.builder(
        itemBuilder: (context, index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Choose'),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }
}
