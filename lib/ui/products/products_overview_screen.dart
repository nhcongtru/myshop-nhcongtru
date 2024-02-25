import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';

import 'products_grid.dart';
import '../shared/app_drawer.dart';

import '../cart/cart_manager.dart';
import 'top_right_badge.dart';

enum FilterOptions{favorite, all}

class ProductsOverviewScreen extends StatefulWidget{
  const ProductsOverviewScreen({super.key,});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen>{
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          ProductFilterMenu(
            onFilterSelected: (filter){
              setState(() {
                if(filter == FilterOptions.favorite){
                  _showOnlyFavorites = true;
                }else{
                  _showOnlyFavorites = false;
                }
              });
            },
          ),
          ShoppingCartButton(
            onPressed: (){
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
      drawer: const AppDrawer(),
    );
  }
}

class ProductFilterMenu extends StatelessWidget{
  const ProductFilterMenu({super.key, this.onFilterSelected});
  
  final void Function(FilterOptions selectedFilter)? onFilterSelected;

  @override
  Widget build(BuildContext context){
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: onFilterSelected,
      itemBuilder: (ctx)
        =>[
          const PopupMenuItem(
            value: FilterOptions.favorite,
            child: Text('Only favorites'),
          ),
          const PopupMenuItem(
            value: FilterOptions.all,
            child: Text('Show all'),
          ),
        ],
    );
  }
}

class ShoppingCartButton extends StatelessWidget{
  const ShoppingCartButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    // Bao IconButton với TopRightBadge
    return TopRightBadge(
      data: CartManager().productCount,
      child: IconButton(
        icon: const Icon(
        Icons.shopping_cart,
        ),
        onPressed: onPressed,
      ),
    );
  }
}