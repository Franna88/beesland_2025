import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildParallaxHero(context),
            _buildStatsCounter(context),
            _buildFeaturedProducts(context),
            _buildStorySection(context),
            _buildWhyChooseUs(context),
            _buildTestimonials(context),
            _buildInstagramFeed(context),
            _buildCallToAction(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildParallaxHero(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'BEESLAND',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'SLAGHUIS & DELI',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 1200),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                    onPressed: () => context.go('/products'),
                    child: const Text('DISCOVER OUR PRODUCTS'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCounter(BuildContext context) {
    final stats = [
      {'number': '25+', 'label': 'YEARS OF\nEXPERIENCE'},
      {'number': '1000+', 'label': 'HAPPY\nCUSTOMERS'},
      {'number': '50+', 'label': 'MEAT\nVARIETIES'},
      {'number': '100%', 'label': 'QUALITY\nGUARANTEED'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.85),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Text(
              'BY THE NUMBERS',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                color: Colors.white70,
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 40,
            runSpacing: 40,
            children: stats.map((stat) => _buildStatItem(stat)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(Map<String, String> stat) {
    return VisibilityDetector(
      key: Key(stat['number']!),
      onVisibilityChanged: (visibilityInfo) {
        // Add counter animation logic here
      },
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24, width: 1),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Column(
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Text(
                stat['number']!,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Text(
                stat['label']!,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  letterSpacing: 2,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorySection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: const NetworkImage(
            '/https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.8),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 2,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 2,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'OUR STORY',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'A Legacy of Quality Since 1998',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 800) {
                      return Row(
                        children: [
                          Expanded(
                            child: FadeInLeft(
                              duration: const Duration(milliseconds: 1200),
                              child: Container(
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(0, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: FadeInRight(
                              duration: const Duration(milliseconds: 1200),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      'For over two decades, we\'ve been serving the finest quality meats to the Jeffrey\'s Bay community. What started as a small family butchery has grown into a beloved local institution, known for our unwavering commitment to quality and traditional craftsmanship.',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        height: 1.8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                      side: const BorderSide(color: Colors.white, width: 2),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () => context.go('/about'),
                                    child: Text(
                                      'READ OUR FULL STORY',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 10),
                                    blurRadius: 20,
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1400),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'For over two decades, we\'ve been serving the finest quality meats to the Jeffrey\'s Bay community. What started as a small family butchery has grown into a beloved local institution, known for our unwavering commitment to quality and traditional craftsmanship.',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  height: 1.8,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                side: const BorderSide(color: Colors.white, width: 2),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => context.go('/about'),
                              child: Text(
                                'READ OUR FULL STORY',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstagramFeed(BuildContext context) {
    final images = [
      'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            'FOLLOW US ON INSTAGRAM',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: images.map((image) => _buildInstagramItem(image)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInstagramItem(String imageUrl) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    final products = [
      {
        'image': 'images/meat_items/beef-steak.jpg',
        'title': 'Premium Steaks',
        'description': 'Hand-selected, perfectly marbled cuts that define excellence',
        'price': 'From R89/kg',
        'tag': 'PREMIUM',
      },
      {
        'image': 'images/meat_items/wors.jpg',
        'title': 'Signature Boerewors',
        'description': 'Our legendary recipe, crafted with tradition and expertise',
        'price': 'R65/kg',
        'tag': 'BESTSELLER',
      },
      {
        'image': 'images/meat_items/biltong.jpg',
        'title': 'Artisanal Biltong',
        'description': 'Perfectly cured and seasoned to perfection',
        'price': 'From R180/kg',
        'tag': 'FEATURED',
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
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'FEATURED PRODUCTS',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'Our Signature Selection',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'Discover our carefully curated selection of premium meats',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color(0xFF4D4D4D),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 1200 ? 80 : 24,
                ),
                child: Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: products.asMap().entries.map((entry) {
                    final index = entry.key;
                    final product = entry.value;
                    return FadeInUp(
                      duration: Duration(milliseconds: 800 + (index * 200)),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => context.go('/products'),
                          child: Container(
                            width: constraints.maxWidth > 1200 
                                ? (constraints.maxWidth - 240) / 3 
                                : constraints.maxWidth > 800 
                                    ? (constraints.maxWidth - 78) / 2 
                                    : constraints.maxWidth - 48,
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
                                        product['image']!,
                                        height: 300,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 20,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2C2C2C),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          product['tag']!,
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
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['title']!,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        product['description']!,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: const Color(0xFF4D4D4D),
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            product['price']!,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF2C2C2C),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2C2C2C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 60),
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                side: const BorderSide(color: Color(0xFF2C2C2C), width: 2),
              ),
              onPressed: () => context.go('/products'),
              child: Text(
                'VIEW ALL PRODUCTS',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUs(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return Row(
              children: [
                Expanded(
                  flex: 6,
                  child: _buildFeaturesList(),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 4,
                  child: FadeInRight(
                    duration: const Duration(milliseconds: 1200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
                        fit: BoxFit.cover,
                        height: 400,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _buildFeaturesList(),
                const SizedBox(height: 32),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildFeaturesList() {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why We\'re the Real McCoy',
            style: GoogleFonts.roboto(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 32),
          _buildFeature(
            Icons.emoji_events,
            'Quality First, Always',
            'We don\'t mess around - only A-grade vleis makes it to our shelves. No shortcuts, no funny business.',
          ),
          const SizedBox(height: 24),
          _buildFeature(
            Icons.handshake,
            'Friendly Service',
            'Come as a customer, leave as family. Our tjommies will sort you out proper!',
          ),
          const SizedBox(height: 24),
          _buildFeature(
            Icons.access_time,
            'Fresh Daily',
            'Everything fresh as can be - we don\'t play games with old vleis.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF4D4D4D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4D4D4D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: const Color(0xFF4D4D4D),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonials(BuildContext context) {
    final testimonials = [
      {
        'text': 'Eish, this place is lekker! Best boerewors in the Bay, no jokes. The ou toppies here know their stuff!',
        'customer': 'Thabo M.',
        'role': 'Regular Customer',
        'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
        'rating': 5,
      },
      {
        'text': 'Been coming here since they opened. Always fresh, always friendly. These okes really care about quality!',
        'customer': 'Susan K.',
        'role': 'Loyal Customer',
        'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
        'rating': 5,
      },
      {
        'text': 'Ag man, where else can you get such lekker vleis and such friendly service? Nowhere, I tell you!',
        'customer': 'Pieter V.',
        'role': 'Happy Customer',
        'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
        'rating': 5,
      },
    ].map((t) => Map<String, dynamic>.from(t)).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2C2C2C),
            const Color(0xFF2C2C2C).withOpacity(0.9),
          ],
        ),
        image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
          alignment: Alignment.center,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            ),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'TESTIMONIALS',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'What Our Customers Say',
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
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'The voice of our community speaks volumes about our commitment to quality',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 1200 ? 80 : 24,
                ),
                child: Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: testimonials.asMap().entries.map((entry) {
                    final index = entry.key;
                    final testimonial = entry.value;
                    return FadeInUp(
                      duration: Duration(milliseconds: 1400 + (index * 200)),
                      child: Container(
                        width: constraints.maxWidth > 1200
                            ? (constraints.maxWidth - 240) / 3
                            : constraints.maxWidth > 800
                                ? (constraints.maxWidth - 78) / 2
                                : constraints.maxWidth - 48,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                testimonial['rating'] as int,
                                (index) => const Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '"${testimonial['text']}"',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                height: 1.8,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(testimonial['image']!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      testimonial['customer']!,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      testimonial['role']!,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF4D4D4D),
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 1000),
        child: Column(
          children: [
            Text(
              'Ready for Some Lekker Vleis?',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Come visit us in Jeffreys Bay and taste the difference quality makes!',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 500) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4D4D4D),
                        ),
                        onPressed: () => context.go('/products'),
                        child: const Text('Browse Our Vleis'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        onPressed: () => context.go('/contact'),
                        child: const Text('Get Directions'),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4D4D4D),
                          ),
                          onPressed: () => context.go('/products'),
                          child: const Text('Browse Our Vleis'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white, width: 2),
                          ),
                          onPressed: () => context.go('/contact'),
                          child: const Text('Get Directions'),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
} 