import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../db/cart_db.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  String? _userId;

  List<CartItem> get items => _items;

  int get total =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> loadCartItems(String userId) async {
    _userId = userId;
    _items = await CartDatabase.instance.getCartItemsByUser(userId);
    notifyListeners();
  }

  Future<void> addItem(CartItem item) async {
    await CartDatabase.instance.insertItem(item);
    print("Added to cart: ${item.name}, Quantity: ${item.quantity}");

    if (_userId != null) {
      await loadCartItems(_userId!);
    }
  }

  Future<void> increment(int index) async {
    final updatedItem = _items[index];
    updatedItem.quantity += 1;
    await CartDatabase.instance.updateItem(updatedItem);

    if (_userId != null) {
      await loadCartItems(_userId!);
    }
  }

  Future<void> decrement(int index) async {
    final updatedItem = _items[index];
    if (updatedItem.quantity > 1) {
      updatedItem.quantity -= 1;
      await CartDatabase.instance.updateItem(updatedItem);

      if (_userId != null) {
        await loadCartItems(_userId!);
      }
    }
  }

  Future<void> clearCart() async {
    if (_userId != null) {
      await CartDatabase.instance.clearCartByUser(_userId!);
      _items = [];
      notifyListeners();
    }
  }
}
