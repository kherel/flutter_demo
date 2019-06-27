import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:my_flutter_course/logic/logic.dart';

class MockProductRepository extends Mock implements ProductRepository {}

// ignore: must_be_immutable, it's not an mistake it's mocking
class MockAppState extends Mock implements AppState {}

AppState mockAppState = MockAppState();

class FakeAppBloc extends Mock implements AppBloc {
  FakeAppBloc() {
    currentState = mockAppState;
  }
  AppState currentState;
}

void main() {
  ProductBloc productBloc;
  AppBloc appBloc;

  ProductRepository productRrepostitory;

  void initProductBloc([initState]) {
    productBloc = ProductBloc(
        //ignore: missing_required_param, it's a mock
        productRepository: productRrepostitory,
        appBloc: appBloc,
        initState: initState);
  }

  group('ProductBloc:', () {
    //ignore: unused_local_variable
    final foo = Product(
      id: 'id',
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
      productRrepostitory = MockProductRepository();
      appBloc = FakeAppBloc();

      when(
        mockAppState.loggedUser,
      ).thenReturn(Me(
        token: 'token',
        id: 'userId',
        userEmail: Email('test@test.com'),
      ));
    });

    test('default initial state is correct', () {
      initProductBloc();
      expect(productBloc.initialState, ProductUninitialized());
    });

    test('custom initial state is correct', () {
      final mockState = ProductReady(products: [], selectedId: 'test id');
      initProductBloc(mockState);
      expect(productBloc.initialState, mockState);
    });

    test('fetch products', () async {
      initProductBloc();

      when(
        productRrepostitory.products(),
      ).thenAnswer(
        (_) => Future.value([foo]),
      );

      final expectedResponse = [
        ProductUninitialized(),
        ProductLoading(),
        ProductReady(products: [foo]),
      ];

      expectLater(
        productBloc.state,
        emitsInOrder(expectedResponse),
      );
      await productBloc.dispatch(FetchProducts());
    });

    test('edit product', () async {
      initProductBloc(ProductReady(products: [foo]));
      final newTitle = 'Bar title';
      var bar = foo.copyWith(title: newTitle);
      final expectedResponse = [
        ProductReady(products: [foo]),
        ProductReady(products: [foo], selectedId: bar.id),
        ProductReady(products: [bar]),
      ];
      when(
        productRrepostitory.update(any),
      ).thenAnswer((i) => Future.value());
      expectLater(
        productBloc.state,
        emitsInOrder(expectedResponse),
      );
      await productBloc.dispatch(SelectProduct(bar.id));
      await productBloc.dispatch(EditProduct(title: newTitle));
      await untilCalled(productRrepostitory.update(any));
      verify(productRrepostitory.update(bar));
    });
    test('delete product', () async {
      initProductBloc(ProductReady(products: [foo]));

      final expectedResponse = [
        ProductReady(products: [foo]),
        ProductReady(products: []),
      ];

      when(
        productRrepostitory.delete(any),
      ).thenAnswer((_) => Future.value());

      expectLater(
        productBloc.state,
        emitsInOrder(expectedResponse),
      );

      await productBloc.dispatch(DeleteProduct(foo.id));
      await untilCalled(productRrepostitory.delete(any));
      verify(productRrepostitory.delete(foo.id));
    });
  });
}
