import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:my_flutter_course/logic/logic.dart';

const String mockImageUri =
    'https://www.handiscover.com/content/wp-content/uploads/2016/08/nice-990x557.jpg';

class ProductRepository {
  ProductRepository({@required this.apiAddress});

  final http.Client httpClient = http.Client();

  final String apiAddress;
  String get apiProducts => '$apiAddress/products.json';
  String apiProduct(String id) => '$apiAddress/products/$id.json';

  Future<List<Product>> products() async {
    final fetchedProductList = <Product>[];

    var response = await http.get(apiProducts);
    final Map<String, dynamic> productListData = json.decode(response.body);

    if (productListData != null) {
      productListData.forEach((productId, productData) {
        var product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: Price(productData['price']),
          isFavorite: productData['isFavorite'],
          author: User(
            id: productData['userId'],
            userEmail: Email(productData['userEmail']),
          ),
        );

        fetchedProductList.add(product);
      });
    }
    return fetchedProductList;
  }

  Future<void> update(Product product) async {
    var data = _prepareToSend(product);
    await http.put(apiProduct(product.id), body: json.encode(data));
  }

  Future<void> delete(String id) async {
    await http.delete(apiProduct(id));
  }
  Future<Product> create(Product product) async {
    var data = _prepareToSend(product);
    final response = await http.post(
      apiProducts,
      body: json.encode(data),
    );

    return Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        image: product.image,
        description: product.description,
        price: product.price,
        isFavorite: product.isFavorite,
        author: product.author);
  }

  Map<String, dynamic> _prepareToSend(Product product) {
    return ({
      "id": product.id,
      "title": product.title,
      "description": product.description,
      "image": product.image,
      "price": product.price,
      "userEmail": product.author.userEmail,
      "userId": product.author.id,
      'isFavorite': product.isFavorite,
    });
  }
  // void delete() {}
}
