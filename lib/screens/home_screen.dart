import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
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
            _buildHeroSection(context),
            _buildFeaturedProducts(context),
            _buildWhyChooseUs(context),
            _buildTestimonials(context),
            _buildCallToAction(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF8F8F8)],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return _buildDesktopHero(context);
          } else if (constraints.maxWidth > 800) {
            return _buildTabletHero(context);
          } else {
            return _buildMobileHero(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopHero(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Beesland Slaghuis & Deli',
                  style: GoogleFonts.roboto(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Die Lekkerste Vleis in Jeffreys Bay!',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'From A-grade steaks to boerewors that\'ll make you weep with joy - we\'ve got the vleis that\'ll make your braai legendary!',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: const Color(0xFF4D4D4D),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/products'),
                      child: const Text('Check out the Vleis'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () => context.go('/contact'),
                      child: const Text('Holla at Us'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 4,
          child: FadeInRight(
            duration: const Duration(milliseconds: 1000),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletHero(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Beesland Slaghuis & Deli',
                style: GoogleFonts.roboto(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4D4D4D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Die Lekkerste Vleis in Jeffreys Bay!',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4D4D4D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'From A-grade steaks to boerewors that\'ll make you weep with joy - we\'ve got the vleis that\'ll make your braai legendary!',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: const Color(0xFF4D4D4D),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/products'),
                    child: const Text('Check out the Vleis'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/contact'),
                    child: const Text('Holla at Us'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        FadeInUp(
          duration: const Duration(milliseconds: 1200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Beesland Slaghuis & Deli',
                style: GoogleFonts.roboto(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4D4D4D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Die Lekkerste Vleis in Jeffreys Bay!',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4D4D4D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'From A-grade steaks to boerewors that\'ll make you weep with joy - we\'ve got the vleis that\'ll make your braai legendary!',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4D4D4D),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/products'),
                      child: const Text('Check out the Vleis'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/contact'),
                      child: const Text('Holla at Us'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        FadeInUp(
          duration: const Duration(milliseconds: 1200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Column(
              children: [
                Text(
                  'Our Kiff Specials',
                  style: GoogleFonts.roboto(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4D4D4D),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'These are the vleis that\'ll make your tjommies jealous',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: const Color(0xFF4D4D4D),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Row(
                  children: [
                    Expanded(child: _buildProductCard(0, context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildProductCard(1, context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildProductCard(2, context)),
                  ],
                );
              } else if (constraints.maxWidth > 800) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildProductCard(0, context)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildProductCard(1, context)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: _buildProductCard(2, context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildProductCard(0, context),
                    const SizedBox(height: 24),
                    _buildProductCard(1, context),
                    const SizedBox(height: 24),
                    _buildProductCard(2, context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index, BuildContext context) {
    final products = [
      {
        'image': 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'title': 'A-Grade Steaks',
        'description': 'Prime cuts that\'ll make you say "Eish, this is lekker!"',
        'price': 'From R89/kg',
      },
      {
        'image': 'https://images.unsplash.com/photo-1684561607487-565ddc54d58f?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Traditional Boerewors',
        'description': 'The real deal - no funny business, just pure lekker wors',
        'price': 'R65/kg',
      },
      {
        'image': 'https://images.unsplash.com/photo-1652209695374-7a91c243f12f?q=80&w=2630&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Droë Wors & Biltong',
        'description': 'Proper biltong that\'ll sort you out - no rubbish here!',
        'price': 'From R180/kg',
      },
    ];

    return FadeInUp(
      duration: Duration(milliseconds: 1000 + (index * 200)),
      child: InkWell(
        onTap: () => context.go('/products'),
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                products[index]['image']!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[index]['title']!,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    products[index]['description']!,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: const Color(0xFF4D4D4D),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    products[index]['price']!,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      },
      {
        'text': 'Been coming here since they opened. Always fresh, always friendly. These okes really care about quality!',
        'customer': 'Susan K.',
        'role': 'Loyal Customer',
      },
      {
        'text': 'Ag man, where else can you get such lekker vleis and such friendly service? Nowhere, I tell you!',
        'customer': 'Pieter V.',
        'role': 'Happy Customer',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'What the Locals Say',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Row(
                  children: testimonials.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> testimonial = entry.value;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 12,
                          right: index == testimonials.length - 1 ? 0 : 12,
                        ),
                        child: _buildTestimonialCard(testimonial, index),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Column(
                  children: testimonials.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> testimonial = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == testimonials.length - 1 ? 0 : 24,
                      ),
                      child: _buildTestimonialCard(testimonial, index),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial, int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 1000 + (index * 200)),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                )),
              ),
              const SizedBox(height: 16),
              Text(
                '"${testimonial['text']!}"',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: const Color(0xFF4D4D4D),
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '- ${testimonial['customer']!}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4D4D4D),
                ),
              ),
              Text(
                testimonial['role']!,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4D4D4D),
                ),
              ),
            ],
          ),
        ),
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