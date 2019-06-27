import 'dart:math';

import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:my_flutter_course/logic/logic.dart';

class ProductForm extends StatefulWidget {
  ProductForm({
    this.product,
    @required this.onSubmit,
    @required this.isLoading,
  });

  final Product product;
  final Function onSubmit;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() {
    return _ProductFormState();
  }
}

const Faker faker = Faker();

class _ProductFormState extends State<ProductForm> {
  Product product;
  Function onSubmit;
  bool isLoading;

  @override
  void initState() {
    product = widget.product;
    onSubmit = widget.onSubmit;
    isLoading = widget.isLoading;
    super.initState();
  }

  final _descriptionFocusNode = FocusNode();
  final _formData = <String, dynamic>{
    'title': faker.internet.userName(),
    'description': faker.conference.name(),
    'price': Price(((Random().nextDouble() * 3000).round() / 100)),
    'image': 'https://www.handiscover.com/content/wp-content/uploads/2016/08/nice-990x557.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();

  Widget _buildTitleTextField() {
    return TextFormField(
      focusNode: _titleFocusNode,
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: product?.title ?? _formData['title'],
      validator: (value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      focusNode: _descriptionFocusNode,
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product Description'),
      initialValue: product?.description ?? _formData['description'],
      validator: (value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required and should be 10+ characters long.';
        }
      },
      onSaved: (value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
  
    var price = product != null ? product.price : _formData['price'];

    return TextFormField(
      focusNode: _priceFocusNode,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      initialValue: price.perItem.toString(),
      validator: (value) {
        if (value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
      onSaved: (value) {
        _formData['price'] = Price(double.parse(value));
      },
    );
  }

  Widget _buildSubmitButton() {
    return isLoading
        ? Center(child: const LinearProgressIndicator())
        : RaisedButton(
            child: const Text('Save'),
            textColor: Colors.white,
            onPressed: _submitForm,
          );
  }

  Widget _buildPageContent(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              const SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    onSubmit(
      title: _formData['title'],
      description: _formData['description'],
      image: _formData['image'],
      price: _formData['price'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageContent = _buildPageContent(context);
    return product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: const Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
