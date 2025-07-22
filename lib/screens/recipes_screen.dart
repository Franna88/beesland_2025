import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeader(context),
            _buildQuickTipsSection(context),
            _buildRecipesGrid(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'RECIPES & TIPS',
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
              'Master the Art of Braai',
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
              'Discover our collection of traditional recipes and expert tips',
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

  Widget _buildQuickTipsSection(BuildContext context) {
    final braaiTips = [
      {
        'icon': Icons.local_fire_department,
        'title': 'Perfect Coals',
        'tip': 'Wait for white-hot coals with no flames - patience makes perfect braai',
      },
      {
        'icon': Icons.thermostat,
        'title': 'Temperature Test',
        'tip': 'Hold your hand 15cm above coals - 3-4 seconds = perfect heat',
      },
      {
        'icon': Icons.schedule,
        'title': 'Timing is Key',
        'tip': 'Start your fire 45 minutes before cooking - good things take time',
      },
      {
        'icon': Icons.restaurant,
        'title': 'Don\'t Rush',
        'tip': 'Turn meat only once - let it sear properly for maximum flavor',
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
                    'EXPERT TIPS',
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
                    'Essential Braai Knowledge',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: braaiTips.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tip = entry.value;
                        return FadeInUp(
                          duration: Duration(milliseconds: 1200 + (index * 200)),
                          child: Container(
                            width: constraints.maxWidth > 1200 
                                ? (constraints.maxWidth - 90) / 4 
                                : constraints.maxWidth > 800 
                                    ? (constraints.maxWidth - 30) / 2 
                                    : constraints.maxWidth,
                            padding: const EdgeInsets.all(32),
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
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2C2C2C),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    tip['icon'] as IconData,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  tip['title'] as String,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF2C2C2C),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  tip['tip'] as String,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF4D4D4D),
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesGrid(BuildContext context) {
    final recipes = [
      {
        'title': 'Perfect Boerewors Braai',
        'description': 'How to braai boerewors like a true South African',
        'time': '15 mins',
        'difficulty': 'Easy',
        'image': 'images/meat_items/wors.jpg',
        'tips': [
          'Don\'t prick the wors - let the natural casing do its magic',
          'Braai slowly over medium coals',
          'Turn gently with tongs, not a fork',
          'Serve with pap, sous, and a cold Castle',
        ],
        'isNew': true,
      },
      {
        'title': 'Legendary Biltong Recipe',
        'description': 'Traditional biltong that\'ll make your ou toppie proud',
        'time': '5-7 days',
        'difficulty': 'Medium',
        'image': 'images/meat_items/biltong.jpg',
        'tips': [
          'Use silverside or topside cuts',
          'Cut with the grain for proper texture',
          'Hang in a cool, dry place with good airflow',
          'Patience is key - don\'t rush the drying process',
        ],
        'isFeatured': true,
      },
      {
        'title': 'Chicken Sosaties',
        'description': 'Juicy and flavorful chicken sosaties that will steal the show',
        'time': '30 mins',
        'difficulty': 'Medium',
        'image': 'images/meat_items/chicken-sosaties.jpg',
        'tips': [
          'Marinate overnight for best results',
          'Don\'t overcrowd the skewers',
          'Keep basting with the marinade',
          'Serve with fresh lemon wedges',
        ],
        'isNew': true,
      },
      {
        'title': 'Perfect Lamb Chops',
        'description': 'Tender and succulent lamb chops with a perfect crust',
        'time': '20 mins',
        'difficulty': 'Medium',
        'image': 'images/meat_items/lamb-chops.jpg',
        'tips': [
          'Bring to room temperature before cooking',
          'Season generously with herbs and garlic',
          'Cook on high heat for a good crust',
          'Rest for 5-10 minutes before serving',
        ],
        'isFeatured': true,
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: const AssetImage('images/meat_items/beef-steak.jpg'),
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
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            ),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'OUR RECIPES',
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
                    'Featured Recipes',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'Try our carefully curated selection of traditional recipes',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: recipes.asMap().entries.map((entry) {
                        final index = entry.key;
                        final recipe = entry.value;
                        return FadeInUp(
                          duration: Duration(milliseconds: 1400 + (index * 200)),
                          child: Container(
                            width: constraints.maxWidth > 1200 
                                ? (constraints.maxWidth - 90) / 3 
                                : constraints.maxWidth > 800 
                                    ? (constraints.maxWidth - 30) / 2 
                                    : constraints.maxWidth,
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
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Image.asset(
                                        recipe['image'] as String,
                                        width: double.infinity,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (recipe['isNew'] == true)
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
                                    if (recipe['isFeatured'] == true)
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
                                            'FEATURED',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              letterSpacing: 1,
                                            ),
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
                                              Icons.access_time,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              recipe['time'] as String,
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          recipe['difficulty'] as String,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        recipe['title'] as String,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        recipe['description'] as String,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          height: 1.6,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Quick Tips:',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            ...(recipe['tips'] as List<String>).take(2).map((tip) => Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '• ',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      tip,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        color: Colors.white70,
                                                        height: 1.4,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )).toList(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Convert recipe titles to consistent IDs
                                            String recipeId = '';
                                            switch(recipe['title']) {
                                              case 'Perfect Boerewors Braai':
                                                recipeId = 'boerewors';
                                                break;
                                              case 'Legendary Biltong Recipe':
                                                recipeId = 'biltong';
                                                break;
                                              case 'Chicken Sosaties':
                                                recipeId = 'chicken-sosaties';
                                                break;
                                              case 'Perfect Lamb Chops':
                                                recipeId = 'lamb-chops';
                                                break;
                                              default:
                                                recipeId = 'boerewors';
                                            }
                                            context.go('/recipe/$recipeId');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: const Color(0xFF2C2C2C),
                                            padding: const EdgeInsets.symmetric(vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'VIEW RECIPE',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
} 