// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_course/logic/logic.dart';
import 'package:my_flutter_course/config/config.dart';
import 'package:http/http.dart' as http;

void main() {
  ProductRepository productRepository;
  final fooProduct = Product(
    title: 'Foo title',
    description: 'description',
    image: 'image',
    price: Price(1.0),
    isFavorite: true,
    author: User(
      id: 'userId',
      userEmail: Email('test@test.com'),
    ),
  );

  setUp(() {
    productRepository = ProductRepository(apiAddress: constantsTest['api']);
  });
  group('ProductRepository:', () {
    test('create record in the base', () async {
      var product = await productRepository.create(fooProduct);
      expect(product.id, isNotNull);
      expect(product.title, fooProduct.title);
      expect(product.description, fooProduct.description);
      expect(product.image, fooProduct.image);
      expect(product.price, fooProduct.price);
      expect(product.isFavorite, fooProduct.isFavorite);
      expect(product.author, fooProduct.author);
    });

    test('show saved products', () async {
      await _cleanDB();
      var product0 = await productRepository.create(fooProduct);
      var product1 = await productRepository.create(fooProduct);
      var products = await productRepository.products();

      expect(products, orderedEquals([product0, product1]));
    });

    test('delete element', () async {
      var product0 = await productRepository.create(fooProduct);
      var product1 = await productRepository.create(fooProduct);
      var product2 = await productRepository.create(fooProduct);

      await productRepository.delete(product1.id);

      var products = await productRepository.products();

      expect(products, containsAllInOrder([product0, product2]));
      expect(products, isNot(contains(product1)));

    });
    group('update:', () {
      test('change instance value, without changing id', () async {
        var originalProduct = await productRepository.create(fooProduct);
        var editedProduct = originalProduct.copyWith(title: 'Bar title');

        expect(originalProduct.id, editedProduct.id);
        expect(originalProduct.title, isNot(editedProduct.title));
      });
      test('update product in product list ', () async {
        var originalProdut = await productRepository.create(fooProduct);
        var originalProduct = originalProdut.copyWith(title: 'Bar title');
        await productRepository.update(originalProduct);
        var products = await productRepository.products();

        expect(
          products,
          allOf([contains(originalProduct), isNot(contains(originalProdut))]),
        );
      });
    });
  });

  tearDownAll(() async {
    await _cleanDB();
    print('all records were deleted');
  });
}

void _cleanDB() async => await http.delete('${constantsTest['api']}/products.json');
