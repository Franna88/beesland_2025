class CartItem {
  final String id;
  final String name;
  final String category;
  final String price;
  final String description;
  final String image;
  final String source;
  final String cookingTip;
  int quantity;
  double weight; // Weight in kg

  CartItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.source,
    required this.cookingTip,
    this.quantity = 1,
    this.weight = 1.0, // Default to 1kg
  });

  double get priceAsDouble {
    // Extract number from price string (e.g., "R89/kg" -> 89.0)
    final regex = RegExp(r'R(\d+)');
    final match = regex.firstMatch(price);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 0.0;
  }

  double get totalPrice => priceAsDouble * quantity * weight;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'image': image,
      'source': source,
      'cookingTip': cookingTip,
      'quantity': quantity,
      'weight': weight,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      source: map['source'],
      cookingTip: map['cookingTip'],
      quantity: map['quantity'],
      weight: map['weight'] ?? 1.0,
    );
  }
} 