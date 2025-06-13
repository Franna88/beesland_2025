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
    'Pork',
    'Chicken',
    'Wors',
    'Biltong',
    'Deli',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'A-Grade Ribeye Steak',
      'category': 'Beef',
      'price': 'R89/kg',
      'description': 'Prime ribeye that\'ll make you say "Eish, this is the real deal!" Juicy, tender, and full of flavour.',
      'image': 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'source': 'Local farm-raised cattle',
      'cookingTip': 'Best braai\'d over medium coals for 3-4 minutes each side',
    },
    {
      'name': 'Traditional Boerewors',
      'category': 'Wors',
      'price': 'R65/kg',
      'description': 'Proper boerewors made the old-school way - no funny business, just pure lekker tradition!',
      'image': 'https://images.unsplash.com/photo-1684561607487-565ddc54d58f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'source': 'Made fresh daily in-store',
      'cookingTip': 'Braai slowly, don\'t prick - let the natural casing do its magic',
    },
    {
      'name': 'Premium Biltong',
      'category': 'Biltong',
      'price': 'R220/kg',
      'description': 'Biltong so good, it\'ll make you weep tears of joy. This is what the ou tannies back in the day would make!',
      'image': 'https://images.unsplash.com/photo-1652209695374-7a91c243f12f?q=80&w=2630&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'source': 'Premium silverside cuts',
      'cookingTip': 'Perfect with a beer and some good tjommies',
    },
    {
      'name': 'Droë Wors',
      'category': 'Biltong',
      'price': 'R180/kg',
      'description': 'Dry wors that\'ll make your ou toppie proud. Perfect for when you need that proper biltong fix!',
      'image': 'https://images.unsplash.com/photo-1603048297172-c92544798d5a?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'source': 'Air-dried using traditional methods',
      'cookingTip': 'No cooking needed - just enjoy as is with a cold one!',
    },
    {
      'name': 'Free-Range Chicken',
      'category': 'Chicken',
      'price': 'R45/kg',
      'description': 'Happy chickens make for lekker eating! These okes had the good life before joining your plate.',
      'image': 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'source': 'Local free-range farms',
      'cookingTip': 'Potjiekos or spatchcock on the braai - either way, it\'s gonna be lekker!',
    },
    {
      'name': 'Pork Chops',
      'category': 'Pork',
      'price': 'R55/kg',
      'description': 'Chops that\'ll make your braai the talk of the neighbourhood. Thick, juicy, and ready to impress!',
      'image': 'https://images.unsplash.com/photo-1592686092916-672fa9e86866?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'source': 'Local pork suppliers',
      'cookingTip': 'Season well and braai over medium heat - don\'t rush the process!',
    },
    {
      'name': 'Gourmet Burgers',
      'category': 'Beef',
      'price': 'R12 each',
      'description': 'Burger patties that\'ll put those fast-food okes to shame. Pure beef, no fillers, just lekker taste!',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'source': '100% pure beef mince',
      'cookingTip': 'Don\'t press down on the patty - let it cook naturally for maximum juiciness',
    },
    {
      'name': 'Artisanal Salami',
      'category': 'Deli',
      'price': 'R95/kg',
      'description': 'Salami so fancy, you\'ll feel like you\'re in Italy. But don\'t worry, it\'s still proudly South African!',
      'image': 'https://images.unsplash.com/photo-1460122109654-7e46ab4fc9b9?q=80&w=2600&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'source': 'Handcrafted in small batches',
      'cookingTip': 'Slice thin and enjoy with good bread and cheese',
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
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF8F8F8)],
        ),
      ),
      child: FadeInDown(
        duration: const Duration(milliseconds: 800),
        child: Column(
          children: [
            Text(
              'Our Lekker Vleis Selection',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'From A-grade steaks to traditional boerewors - we\'ve got all the vleis your heart desires!',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 32,
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Column(
          children: [
            // Search Bar
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for your favourite vleis...',
                  hintStyle: GoogleFonts.roboto(
                    color: const Color(0xFF4D4D4D).withOpacity(0.6),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF4D4D4D),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF4D4D4D)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: const Color(0xFF4D4D4D).withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF4D4D4D), width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Category Filter
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4D4D4D) : Colors.transparent,
                      border: Border.all(
                        color: const Color(0xFF4D4D4D),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF4D4D4D),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 32,
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
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.75,
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
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Product Info
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product['name'],
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4D4D4D),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4D4D4D).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product['category'],
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4D4D4D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    product['price'],
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Expanded(
                    child: Text(
                      product['description'],
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: const Color(0xFF4D4D4D),
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Source
                  Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: Color(0xFF4D4D4D),
                      ),
                      const SizedBox(width: 4),
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
                  const SizedBox(height: 12),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showWeightSelector(product),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_shopping_cart, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _cartService.isInCart(product['name']) 
                                ? 'In Cart (${_cartService.getQuantity(product['name'])})'
                                : 'Add to Cart',
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