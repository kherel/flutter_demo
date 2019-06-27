import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:my_flutter_course/logic/logic.dart';

class FilteredProductsBloc extends Bloc<FilteredPEvent, FilteredPState> {
  FilteredProductsBloc({@required this.productBloc}) {
    productsSubscription = productBloc.state.listen(
      (state) {
        if (state is ProductReady) {
          dispatch(
            UpdateFiteredProducts(
              (productBloc.currentState as ProductReady).products,
            ),
          );
        }
      },
    );
  }

  final ProductBloc productBloc;
  StreamSubscription productsSubscription;

  @override
  void dispose() {
    productsSubscription.cancel();
    super.dispose();
  }

  @override
  FilteredPState get initialState {
    return productBloc.currentState is ProductReady
        ? FilteredPReady(
            (productBloc.currentState as ProductReady).products,
            isOnlyFavorite: false,
          )
        : FilteredPLoading(isOnlyFavorite: false);
  }

  @override
  Stream<FilteredPState> mapEventToState(
    FilteredPEvent event,
  ) async* {
    switch (event.runtimeType) {
      case UpdateFavFilter:
        yield* _mapUpdateFilterToState(event);
        break;
      case UpdateFiteredProducts:
        yield* _mapProductsToState(event);
        break;
    }
  }

  Stream<FilteredPReady> _mapUpdateFilterToState(UpdateFavFilter event) async* {
    assert(
      productBloc.currentState is ProductReady,
      'wronge state, ${productBloc.currentState.runtimeType}',
    );
    yield FilteredPReady(
      _mapProuductsToFilteredProuducts(
        (productBloc.currentState as ProductReady).products,
        event.isOnlyFavorite,
      ),
      isOnlyFavorite: event.isOnlyFavorite,
    );
  }

  List<Product> _mapProuductsToFilteredProuducts(
    List<Product> products,
    bool isOnlyFavorite,
  ) {
    if (isOnlyFavorite) {
      return products.where((p) => p.isFavorite).toList();
    } else {
      return products;
    }
  }

  Stream<FilteredPReady> _mapProductsToState(event) async* {
    bool isOnlyFavorite;
    if (currentState is FilteredPReady) {
      isOnlyFavorite = (currentState as FilteredPReady).isOnlyFavorite;
    } else {
      isOnlyFavorite = false;
    }

    final products = (productBloc.currentState as ProductReady).products;
    yield FilteredPReady(
      _mapProuductsToFilteredProuducts(
        products,
        isOnlyFavorite,
      ),
      isOnlyFavorite: isOnlyFavorite,
    );
  }
}
