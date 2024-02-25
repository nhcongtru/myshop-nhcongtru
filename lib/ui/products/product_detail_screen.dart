import 'package:flutter/material.dart';

import '../../models/product.dart';

import '../cart/cart_screen.dart';

import '../cart/cart_manager.dart';
import 'top_right_badge.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    int _slsp = 1; 

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          CartButton(
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => CartScreen(),
                  transitionDuration: Duration(milliseconds: 500), // Thời gian chuyển động
                  transitionsBuilder: (context, animation1, animation2, child) {
                    animation1 = CurvedAnimation(parent: animation1, curve: Curves.easeInOut); // Đặt hiệu ứng curve ở đây
                    
                    // Sử dụng Tween để tạo hiệu ứng chuyển động cong
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1.0, 0.0), // Chuyển từ phải qua
                        end: Offset.zero, // Đến vị trí bắt đầu
                      ).animate(animation1),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              color: Theme.of(context).colorScheme.secondaryContainer,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã thêm sản phẩm vào danh sách yêu thích')),
                );
              },
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Số lượng:'),
                const SizedBox(width: 30, height: 20),
                Container(
                  width: 50,
                  child: TextFormField(
                    initialValue: '1',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {_slsp = int.parse(value);},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã thêm $_slsp sản phẩm vào giỏ hàng')),
                );
              },
              child: const Text('Thêm vào giỏ hàng'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget{
  const CartButton({super.key, this.onPressed});

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

