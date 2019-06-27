import 'package:meta/meta.dart';
import 'package:my_flutter_course/logic/logic.dart';
import 'package:equatable/equatable.dart';

import './user.dart';

class Product extends Equatable {
  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.author,
    this.isFavorite = false,
  }) : super([id, title, description, price, image, author, isFavorite]);

  
  final String title, description, image, id;
  final User author;
  final Price price;
  final bool isFavorite;

  @override
  String toString() {
    return 'Product instance id:$id';
  }

  Product copyWith({
    String title,
    String description,
    String price,
    String image,
    bool isFavorite,
  }) {
    return Product(
      id: id,
      author: author,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
