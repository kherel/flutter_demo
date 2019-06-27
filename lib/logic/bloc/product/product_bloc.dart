import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:my_flutter_course/logic/logic.dart';

import './bloc.dart';

const _mockImage =
    'https://www.handiscover.com/content/wp-content/uploads/2016/08/nice-990x557.jpg';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({@required this.productRepository, this.appBloc, this.initState});

  final ProductRepository productRepository;
  final AppBloc appBloc;
  final ProductState initState;

  @override
  ProductState get initialState => initState ?? ProductUninitialized();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SelectProduct:
        yield* _mapIdEventToState(event);
        break;
      case ToggleFavoriteProduct:
        yield* _mapIdEventToState(event);
        break;
      case EditProduct:
        yield* _mapEditToState(event);

        break;
      case DeleteProduct:
        yield* _mapIdEventToState(event);
        break;
      case CreateProduct:
        yield* _mapCreateToState(event);
        break;
      case FetchProducts:
        yield ProductLoading();
        var products = await productRepository.products();
        yield ProductReady(products: products);

        break;
    }
  }

  Stream<ProductState> _mapEditToState(EditProduct event) async* {
    final originProduct = (currentState as ProductReady).selectedProduct();
    final products = (currentState as ProductReady).products;
    final productIndex = products.indexWhere((p) => p.id == originProduct.id);
    final localUser = appBloc.currentState.loggedUser;
    final newProduct = Product(
      id: originProduct.id,
      title: event.title ?? originProduct.title,
      description: event.description ?? originProduct.description,
      image: event.image ?? originProduct.image,
      price: event.price ?? originProduct.price,
      author: User(id: localUser.id, userEmail: localUser.userEmail),
      isFavorite: originProduct.isFavorite,
    );
    products[productIndex] = newProduct;

    yield ProductReady(products: products);
    //optimistic update
    productRepository.update(newProduct);
  }

  Stream<ProductState> _mapCreateToState(CreateProduct event) async* {
    final products = List<Product>.from(
      (currentState as ProductReady).products,
    );
    final product = Product(
      title: event.title,
      description: event.description,
      image: _mockImage,
      price: event.price,
      author: appBloc.currentState.loggedUser,
      isFavorite: false,
    );
    var newProduct = await productRepository.create(product);
    products.add(newProduct);
    yield ProductReady(products: products);
  }

  Stream<ProductState> _mapIdEventToState(ProductIdEvent event) async* {
    final productId = event.selectedId;
    final products = List<Product>.from(
      (currentState as ProductReady).products,
    );

    switch (event.runtimeType) {
      case SelectProduct:
        yield ProductReady(products: products, selectedId: productId);
        break;
      case DeleteProduct:
        final newProducts = products.where((p) => p.id != productId).toList();
        yield ProductReady(products: newProducts);
        //optimistic
        productRepository.delete(productId);
        break;
      case ToggleFavoriteProduct:
        final productIdx = products.indexWhere((p) => p.id == productId);

        var product = products[productIdx];
        var updatedProduct = product.copyWith(
          isFavorite: !product.isFavorite,
        );
        products[productIdx] = updatedProduct;
        yield ProductReady(products: products, selectedId: productId);
        //optimistic update
        productRepository.update(updatedProduct);
    }
  }
}
