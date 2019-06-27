import 'package:flutter/material.dart';
import 'package:my_flutter_course/ui/screens/screens.dart';

import './create.dart';
import './list.dart';

class AdminPage extends StatelessWidget {
  static const String routeName = '/admin';

Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Choose'),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ProductsList.routeName);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: const Text('Manage Products'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[ProductCreate(), ProductListPage()],
        ),
      ),
    );
  }
}
