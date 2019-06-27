import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'config/config.dart';
import 'logic/logic.dart';
import 'ui/screens/screens.dart';

void main() {
  loggerConfig();
  blocSupervisorConfig();
  final rootMaterialWidget = MyMaterialApp();
  runApp(BlocProvidersWidget(main: rootMaterialWidget));
}

class BlocProvidersWidget extends StatelessWidget {
  BlocProvidersWidget({Key key, this.main}) : super(key: key);

  final Widget main;

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc();
    final authBloc = AuthBloc(
      userRepository: UserRepository(),
      appBloc: appBloc,
    );
    final productBloc = ProductBloc(
      productRepository: ProductRepository(apiAddress: constants['api']),
      appBloc: appBloc,
    );

    return BlocProviderTree(blocProviders: [
      BlocProvider<AppBloc>(bloc: appBloc),
      BlocProvider<AuthBloc>(bloc: authBloc),
      BlocProvider<ProductBloc>(bloc: productBloc),
    ], child: main);
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re-think flutter course',
      debugShowCheckedModeBanner: false,
      theme: themeConfig(),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        AdminPage.routeName: (_) => AdminPage(),
        ProductsList.routeName: (_) => ProductsList(),
        ProductEdit.routeName: (_) => ProductEdit(),
        ProductShow.routeName: (_) => ProductShow(),
      },
    );
  }
}
