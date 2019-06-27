import 'package:flutter/material.dart';
import 'package:my_flutter_course/logic/logic.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProductBloc>(context);

    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            var product = state.products[index];
            handleOpenEdit() => bloc.dispatch(SelectProduct(product.id));

            return Dismissible(
              key: Key(product.id),
              onDismissed: (direction) {
                bloc.dispatch(DeleteProduct(product.id));
              },
              background: Container(color: Colors.red),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product.image),
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toString()}'),
                    trailing: _buildEditButton(
                      context,
                      product,
                      handleOpenEdit,
                    ),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: state.products.length,
        );
      },
    );
  }

  Widget _buildEditButton(context, product, handleOpenEdit) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        handleOpenEdit();
        Navigator.of(context).pushNamed('/edit');
      },
    );
  }
}
