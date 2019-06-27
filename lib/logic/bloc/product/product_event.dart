import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:my_flutter_course/logic/logic.dart';

@immutable
abstract class ProductEvent extends Equatable {
  ProductEvent([props]) : super(props);
}

//events that contain product id
abstract class ProductIdEvent extends ProductEvent {
  ProductIdEvent(this.selectedId) : super([selectedId]);

  final String selectedId;
}

class SelectProduct extends ProductIdEvent {
  SelectProduct(this.selectedId) : super(selectedId);

  final String selectedId;

  @override
  String toString() => 'Select product $selectedId';
}

class DeleteProduct extends ProductIdEvent {
  DeleteProduct(this.selectedId) : super(selectedId);

  final String selectedId;

  @override
  String toString() => 'Delete product $selectedId';
}

class ToggleFavoriteProduct extends ProductIdEvent {
  ToggleFavoriteProduct(this.selectedId) : super(selectedId);

  final String selectedId;

  @override
  String toString() => 'ToggleProduct $selectedId';
}

class CreateProduct extends ProductEvent {
  CreateProduct({
    this.title,
    this.description,
    this.image,
    this.price,
  }) : super([
          title,
          description,
          image,
          price,
        ]);

  final String title, description, image;
  final Price price;
  @override
  String toString() => 'Create title: $title';
}

class EditProduct extends ProductEvent {
  EditProduct({
    this.title,
    this.description,
    this.image,
    this.price,
  }) : super([
          title,
          description,
          image,
          price,
        ]);
  final String title, description, image;
  final Price price;

  @override
  String toString() => 'Edit $title, $description, $image, $price';
}

class FetchProducts extends ProductEvent {
  @override
  String toString() => 'FetchProducts';
}
