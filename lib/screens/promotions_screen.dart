import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeader(context),
            _buildPromotionsGrid(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: const AssetImage('images/meat_items/biltong.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'SPECIAL OFFERS',
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
              'Exclusive Deals & Promotions',
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
              'Don\'t miss out on these lekker deals - limited time only!',
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

  Widget _buildPromotionsGrid(BuildContext context) {
    final promotions = [
      {
        'title': 'Weekend Braai Special',
        'description': '2kg Boerewors + 2kg Steak + 1kg Chops',
        'originalPrice': 'R450',
        'salePrice': 'R380',
        'savings': 'Save R70!',
        'validUntil': '2024-12-31',
        'image': 'images/meat_items/wors.jpg',
        'isHot': true,
      },
      {
        'title': 'Biltong Bonanza',
        'description': '500g Premium Biltong + 300g Droë Wors',
        'originalPrice': 'R180',
        'salePrice': 'R150',
        'savings': 'Save R30!',
        'validUntil': '2024-12-25',
        'image': 'images/meat_items/biltong.jpg',
        'isHot': false,
      },
      {
        'title': 'Family Pack Deal',
        'description': '3kg Mixed Vleis Perfect for the Family',
        'originalPrice': 'R320',
        'salePrice': 'R280',
        'savings': 'Save R40!',
        'validUntil': '2024-12-30',
        'image': 'images/meat_items/lamb-chops.jpg',
        'isHot': false,
      },
      {
        'title': 'Pensioner Special',
        'description': '10% off all purchases on Wednesdays',
        'originalPrice': 'Regular Prices',
        'salePrice': '10% OFF',
        'savings': 'Every Wednesday!',
        'validUntil': 'Ongoing',
        'image': 'images/meat_items/chicken-sosaties.jpg',
        'isHot': false,
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: promotions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final promotion = entry.value;
                    return FadeInUp(
                      duration: Duration(milliseconds: 1000 + (index * 200)),
                      child: Container(
                        width: constraints.maxWidth > 1200 
                            ? (constraints.maxWidth - 90) / 3 
                            : constraints.maxWidth > 800 
                                ? (constraints.maxWidth - 30) / 2 
                                : constraints.maxWidth,
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
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    promotion['image'] as String,
                                    width: double.infinity,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (promotion['isHot'] == true)
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red[600],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.local_fire_department,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'HOT DEAL',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2C2C2C).withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.schedule,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Valid until: ${promotion['validUntil']}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    promotion['title'] as String,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2C2C2C),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    promotion['description'] as String,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: const Color(0xFF4D4D4D),
                                      height: 1.6,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      if (promotion['originalPrice'] != 'Regular Prices')
                                        Text(
                                          promotion['originalPrice'] as String,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF4D4D4D).withOpacity(0.6),
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      if (promotion['originalPrice'] != 'Regular Prices')
                                        const SizedBox(width: 12),
                                      Text(
                                        promotion['salePrice'] as String,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green[50],
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.green[200]!,
                                      ),
                                    ),
                                    child: Text(
                                      promotion['savings'] as String,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green[700],
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () => _addToCart(context, promotion),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2C2C2C),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'ADD TO CART',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, Map<String, dynamic> promotion) {
    final cartItem = CartItem(
      id: 'special_${promotion['title'].toString().toLowerCase().replaceAll(' ', '_')}',
      name: promotion['title'],
      category: 'Special Offer',
      price: promotion['salePrice'],
      description: promotion['description'],
      image: promotion['image'],
      source: 'Beesland Special',
      cookingTip: 'Enjoy this special deal with family and friends!',
      quantity: 1,
      weight: 1.0,
    );

    _cartService.addItem(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${promotion['title']} added to cart!',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
} 