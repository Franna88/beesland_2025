import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import '../widgets/weight_selector_dialog.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  final CartService _cartService = CartService();

  final List<String> categories = [
    'All',
    'Beef',
    'Lamb',
    'Chicken',
    'Wors',
    'Biltong',
    'Deli',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Premium Beef Steak',
      'category': 'Beef',
      'price': 'R189/kg',
      'description': 'Hand-selected, perfectly marbled cuts that define excellence. Each steak is aged to perfection for maximum tenderness and flavor.',
      'image': 'images/meat_items/beef-steak.jpg',
      'source': 'Local grass-fed cattle',
      'cookingTip': 'Best served medium-rare, rested for 5-10 minutes after cooking',
      'isNew': true,
      'isBestseller': true,
    },
    {
      'name': 'Traditional Boerewors',
      'category': 'Wors',
      'price': 'R85/kg',
      'description': 'Our signature boerewors, made fresh daily using a generations-old recipe. Perfect blend of beef and spices.',
      'image': 'images/meat_items/wors.jpg',
      'source': 'Made fresh daily in-store',
      'cookingTip': 'Grill slowly over medium heat, maintaining the spiral shape',
      'isNew': false,
      'isBestseller': true,
    },
    {
      'name': 'Artisanal Biltong',
      'category': 'Biltong',
      'price': 'R280/kg',
      'description': 'Premium cuts of beef, perfectly spiced and dried to perfection. Available in traditional or peri-peri flavor.',
      'image': 'images/meat_items/biltong.jpg',
      'source': 'Premium silverside cuts',
      'cookingTip': 'Ready to eat, best stored in a cool, dry place',
      'isNew': false,
      'isBestseller': true,
    },
    {
      'name': 'Chicken Sosaties',
      'category': 'Chicken',
      'price': 'R95/kg',
      'description': 'Tender chicken pieces marinated in our special blend of herbs and spices, skewered with onions and peppers.',
      'image': 'images/meat_items/chicken-sosaties.jpg',
      'source': 'Free-range chicken',
      'cookingTip': 'Grill for 12-15 minutes, turning occasionally',
      'isNew': true,
      'isBestseller': false,
    },
    {
      'name': 'Premium Lamb Chops',
      'category': 'Lamb',
      'price': 'R225/kg',
      'description': 'Succulent Karoo lamb chops, perfect for your next braai. Known for their exceptional flavor and tenderness.',
      'image': 'images/meat_items/lamb-chops.jpg',
      'source': 'Karoo free-range lamb',
      'cookingTip': 'Season well with herbs and garlic, grill to medium',
      'isNew': false,
      'isBestseller': false,
    },
    {
      'name': 'Grass-fed Beef Mince',
      'category': 'Beef',
      'price': 'R95/kg',
      'description': 'Premium ground beef from grass-fed cattle. Perfect for burgers, bolognese, or any mince dish.',
      'image': 'images/meat_items/beef-mince.jpg',
      'source': 'Local grass-fed cattle',
      'cookingTip': 'Best cooked medium to maintain juiciness',
      'isNew': false,
      'isBestseller': false,
    },
    {
      'name': 'Traditional Oxtail',
      'category': 'Beef',
      'price': 'R165/kg',
      'description': 'Perfect for slow-cooking, our oxtail is well-trimmed and ideal for traditional South African oxtail stew.',
      'image': 'images/meat_items/oxtail.jpg',
      'source': 'Local farm-raised cattle',
      'cookingTip': 'Slow cook for 4-5 hours until tender',
      'isNew': true,
      'isBestseller': false,
    },
    {
      'name': 'Halloumi Poppers',
      'category': 'Deli',
      'price': 'R85/pack',
      'description': 'Grilled halloumi cheese wrapped in bacon, perfect as a starter or snack.',
      'image': 'images/meat_items/halloumi-poppers.jpg',
      'source': 'Made fresh in our deli',
      'cookingTip': 'Grill until bacon is crispy, serve immediately',
      'isNew': true,
      'isBestseller': true,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' || product['category'] == selectedCategory;
      final matchesSearch = product['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
                           product['description'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeader(),
            _buildSearchAndFilter(),
            _buildProductsGrid(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: const AssetImage('images/meat_items/beef-steak.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'PREMIUM MEATS',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Text(
              'Quality You Can Taste',
              style: GoogleFonts.playfairDisplay(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInDown(
            duration: const Duration(milliseconds: 1200),
            child: Text(
              'From premium cuts to traditional favorites',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white70,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search our selection...',
                hintStyle: GoogleFonts.roboto(
                  color: const Color(0xFF4D4D4D).withOpacity(0.6),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4D4D4D)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () => setState(() => selectedCategory = category),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2C2C2C) : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2C2C2C) : const Color(0xFFDDDDDD),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF4D4D4D),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
        vertical: 60,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 1;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 0.8,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                duration: Duration(milliseconds: 600 + (index * 100)),
                child: _buildProductCard(filteredProducts[index]),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    product['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product['isNew'] == true)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'NEW',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                if (product['isBestseller'] == true)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'BESTSELLER',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product['category'],
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4D4D4D),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product['name'],
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['price'],
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      product['description'],
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: const Color(0xFF4D4D4D),
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: Color(0xFF4D4D4D),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          product['source'],
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: const Color(0xFF4D4D4D),
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showWeightSelector(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C2C2C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_shopping_cart, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _cartService.isInCart(product['name'])
                                ? 'Update Cart (${_cartService.getQuantity(product['name'])}kg)'
                                : 'Add to Cart',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeightSelector(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => WeightSelectorDialog(
        productName: product['name'],
        price: product['price'],
        initialWeight: 1.0,
        onWeightSelected: (weight) => _addToCart(product, weight),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product, double weight) {
    final cartItem = CartItem(
      id: product['name'], // Using name as ID for simplicity
      name: product['name'],
      category: product['category'],
      price: product['price'],
      description: product['description'],
      image: product['image'],
      source: product['source'],
      cookingTip: product['cookingTip'],
      quantity: 1,
      weight: weight,
    );

    _cartService.addItem(cartItem);
    
    // Show snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} (${weight}kg) added to cart!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () => context.go('/cart'),
        ),
      ),
    );
    
    setState(() {}); // Refresh to update button text
  }
} 