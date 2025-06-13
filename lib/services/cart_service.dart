import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];
  
  List<CartItem> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  
  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    
    notifyListeners();
  }
  
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
  
  void updateQuantity(String itemId, int quantity) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }
  
  void updateWeight(String itemId, double weight) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (weight <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].weight = weight;
      }
      notifyListeners();
    }
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  
  bool isInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }
  
  int getQuantity(String itemId) {
    final item = _items.firstWhere(
      (item) => item.id == itemId,
      orElse: () => CartItem(
        id: '',
        name: '',
        category: '',
        price: '',
        description: '',
        image: '',
        source: '',
        cookingTip: '',
        quantity: 0,
      ),
    );
    return item.quantity;
  }
} 