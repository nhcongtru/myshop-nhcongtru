import 'package:flutter/material.dart';

import 'user_product_list_tile.dart';
import 'products_manager.dart';

import '../shared/app_drawer.dart';

class UserProductsScreen extends StatelessWidget{
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: <Widget>[
          AddUserProductButton(
            onPressed: (){
              print('Go to edit product screen');
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: const UserProductList(),
    );
  }
}

class UserProductList extends StatelessWidget{
  const UserProductList({super.key});

  @override
  Widget build(BuildContext context){
    final productsManager = ProductsManager();

    return ListView.builder(
      itemCount: productsManager.itemCount,
      itemBuilder: (ctx, i) => Column(
        children: [
          UserProductListTile(
            productsManager.items[i],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class AddUserProductButton extends StatelessWidget{
  const AddUserProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context){
    return IconButton(onPressed: onPressed,
    icon: const Icon(Icons.add),);
  }
}