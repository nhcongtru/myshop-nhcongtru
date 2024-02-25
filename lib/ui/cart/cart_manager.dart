import '../../models/cart_item.dart';

class CartManager {
  final Map<String, CartItem> _items = {
    'p1' : CartItem(
      id: 'C1',
      title: 'Red Shirt',
      imageUrl: 
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      quantity: 2,
      price: 29.99,
    ),
  };

  int get productCount{
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String,CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }
}