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
              'Current Specials & Deals',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Don\'t miss out on these lekker deals - limited time only!',
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

  Widget _buildPromotionsGrid(BuildContext context) {
    final promotions = [
      {
        'title': 'Weekend Braai Special',
        'description': '2kg Boerewors + 2kg Steak + 1kg Chops',
        'originalPrice': 'R450',
        'salePrice': 'R380',
        'savings': 'Save R70!',
        'validUntil': '2024-12-31',
        'image': 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'isHot': true,
      },
      {
        'title': 'Biltong Bonanza',
        'description': '500g Premium Biltong + 300g Droë Wors',
        'originalPrice': 'R180',
        'salePrice': 'R150',
        'savings': 'Save R30!',
        'validUntil': '2024-12-25',
        'image': 'https://images.unsplash.com/photo-1652209695374-7a91c243f12f?q=80&w=2630&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'isHot': false,
      },
      {
        'title': 'Family Pack Deal',
        'description': '3kg Mixed Vleis Perfect for the Family',
        'originalPrice': 'R320',
        'salePrice': 'R280',
        'savings': 'Save R40!',
        'validUntil': '2024-12-30',
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'isHot': false,
      },
      {
        'title': 'Pensioner Special',
        'description': '10% off all purchases on Wednesdays',
        'originalPrice': 'Regular Prices',
        'salePrice': '10% OFF',
        'savings': 'Every Wednesday!',
        'validUntil': 'Ongoing',
        'image': 'https://images.unsplash.com/photo-1611038333075-2efd28705f42?q=80&w=2749&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'isHot': false,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 1200;
          
          if (isDesktop) {
            // Desktop: 2 columns using Row/Column layout
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: _buildPromotionCard(promotions[0]),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        child: _buildPromotionCard(promotions[1]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: _buildPromotionCard(promotions[2]),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: _buildPromotionCard(promotions[3]),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            // Mobile: Single column
            return Column(
              children: promotions.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: entry.key < promotions.length - 1 ? 24 : 0),
                  child: FadeInUp(
                    duration: Duration(milliseconds: 600 + (entry.key * 200)),
                    child: _buildPromotionCard(entry.value),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Widget _buildPromotionCard(Map<String, dynamic> promotion) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    promotion['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      promotion['title'],
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4D4D4D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      promotion['description'],
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: const Color(0xFF4D4D4D),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (promotion['originalPrice'] != 'Regular Prices') ...[
                          Text(
                            promotion['originalPrice'],
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: const Color(0xFF4D4D4D).withOpacity(0.6),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          promotion['salePrice'],
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Text(
                        promotion['savings'],
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: const Color(0xFF4D4D4D).withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Valid until: ${promotion['validUntil']}',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: const Color(0xFF4D4D4D).withOpacity(0.7),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _addToCart(context, promotion),
                        icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                        label: Text(
                          'Add Special to Cart',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4D4D4D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (promotion['isHot'] == true)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'HOT DEAL',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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
      weight: 1.0, // Specials are sold as complete packages
    );

    _cartService.addItem(cartItem);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${promotion['title']} added to cart!',
                style: GoogleFonts.roboto(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
} 