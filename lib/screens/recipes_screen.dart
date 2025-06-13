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
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1200 ? 80 : (screenWidth > 800 ? 48 : 16),
        vertical: screenWidth > 800 ? 60 : 40,
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
              'Lekker Recipes & Braai Tips',
              style: GoogleFonts.roboto(
                fontSize: screenWidth > 800 ? 36 : 28,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth > 800 ? 16 : 12),
            Text(
              'Make your braai legendary with our tried and tested recipes!',
              style: GoogleFonts.roboto(
                fontSize: screenWidth > 800 ? 18 : 16,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTipsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final braaiTips = [
      {
        'icon': Icons.local_fire_department,
        'title': 'Perfect Coals',
        'tip': 'Wait for white-hot coals with no flames - patience makes perfect braai',
        'color': const Color(0xFF4D4D4D),
      },
      {
        'icon': Icons.thermostat,
        'title': 'Temperature Test',
        'tip': 'Hold your hand 15cm above coals - 3-4 seconds = perfect heat',
        'color': const Color(0xFF4D4D4D),
      },
      {
        'icon': Icons.schedule,
        'title': 'Timing is Key',
        'tip': 'Start your fire 45 minutes before cooking - good things take time',
        'color': const Color(0xFF4D4D4D),
      },
      {
        'icon': Icons.restaurant,
        'title': 'Don\'t Rush',
        'tip': 'Turn meat only once - let it sear properly for maximum flavor',
        'color': const Color(0xFF4D4D4D),
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1200 ? 80 : (screenWidth > 800 ? 48 : 16),
        vertical: screenWidth > 800 ? 60 : 40,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8F8F8), Color(0xFFEEEEEE)],
        ),
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Quick Braai Tips',
              style: GoogleFonts.roboto(
                fontSize: screenWidth > 800 ? 28 : 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenWidth > 800 ? 40 : 24),
          // Use Column for mobile, GridView for desktop
          if (screenWidth <= 800) ...[
            ...braaiTips.asMap().entries.map((entry) {
              final index = entry.key;
              final tip = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index < braaiTips.length - 1 ? 16 : 0),
                child: FadeInUp(
                  duration: Duration(milliseconds: 800 + (index * 150)),
                  child: _buildTipCard(tip),
                ),
              );
            }).toList(),
          ] else ...[
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                double childAspectRatio;
                
                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 4;
                  childAspectRatio = 1.1;
                } else {
                  crossAxisCount = 2;
                  childAspectRatio = 2.2;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: braaiTips.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      duration: Duration(milliseconds: 800 + (index * 150)),
                      child: _buildTipCard(braaiTips[index]),
                    );
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth <= 800;
        
        if (isMobile) {
          return _buildMobileTipCard(tip);
        } else {
          return _buildDesktopTipCard(tip);
        }
      },
    );
  }

  Widget _buildMobileTipCard(Map<String, dynamic> tip) {
    return Container(
      height: 120, // Fixed height to prevent overflow
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon section
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4D4D4D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              tip['icon'],
              size: 24,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(width: 16),
          // Content section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tip['title'],
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4D4D4D),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    tip['tip'],
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: const Color(0xFF4D4D4D),
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTipCard(Map<String, dynamic> tip) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4D4D4D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              tip['icon'],
              size: 32,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tip['title'],
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF4D4D4D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            tip['tip'],
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: const Color(0xFF4D4D4D),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final recipes = [
      {
        'title': 'Perfect Boerewors Braai',
        'description': 'How to braai boerewors like a true South African',
        'time': '15 mins',
        'difficulty': 'Easy',
        'image': 'https://images.unsplash.com/photo-1591989330748-777649e84466?q=80&w=2333&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'tips': [
          'Don\'t prick the wors - let the natural casing do its magic',
          'Braai slowly over medium coals',
          'Turn gently with tongs, not a fork',
          'Serve with pap, sous, and a cold Castle',
        ],
      },
      {
        'title': 'Legendary Biltong Recipe',
        'description': 'Traditional biltong that\'ll make your ou toppie proud',
        'time': '5-7 days',
        'difficulty': 'Medium',
        'image': 'https://images.unsplash.com/photo-1652209695374-7a91c243f12f?q=80&w=2630&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'tips': [
          'Use silverside or topside cuts',
          'Cut with the grain for proper texture',
          'Hang in a cool, dry place with good airflow',
          'Patience is key - don\'t rush the drying process',
        ],
      },
      {
        'title': 'Potjiekos Special',
        'description': 'A hearty potjie that\'ll feed the whole family',
        'time': '2-3 hours',
        'difficulty': 'Medium',
        'image': 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'tips': [
          'Brown the meat first for maximum flavour',
          'Layer ingredients - don\'t stir too much',
          'Use a good cast iron potjie pot',
          'Low and slow is the way to go',
        ],
      },
      {
        'title': 'Braai Chops Perfection',
        'description': 'Juicy pork chops that\'ll make you the braai master',
        'time': '20 mins',
        'difficulty': 'Easy',
        'image': 'https://images.unsplash.com/photo-1592686092916-672fa9e86866?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'tips': [
          'Season well with coarse salt and pepper',
          'Let them come to room temperature first',
          'Don\'t move them too much - let them sear',
          'Rest for 5 minutes before serving',
        ],
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1200 ? 80 : (screenWidth > 800 ? 48 : 16),
        vertical: screenWidth > 800 ? 80 : 40,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Featured Recipes',
              style: GoogleFonts.roboto(
                fontSize: screenWidth > 800 ? 32 : 26,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenWidth > 800 ? 50 : 30),
          // Use Column instead of GridView for mobile to prevent overflow
          if (screenWidth <= 800) ...[
            ...recipes.asMap().entries.map((entry) {
              final index = entry.key;
              final recipe = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index < recipes.length - 1 ? 24 : 0),
                child: FadeInUp(
                  duration: Duration(milliseconds: 800 + (index * 200)),
                  child: _buildRecipeCard(recipe, index, context),
                ),
              );
            }).toList(),
          ] else ...[
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 1200 ? 2 : 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    childAspectRatio: crossAxisCount == 1 ? 1.6 : 1.2,
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      duration: Duration(milliseconds: 800 + (index * 200)),
                      child: _buildRecipeCard(recipes[index], index, context),
                    );
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe, int index, BuildContext context) {
    final recipeIds = ['boerewors', 'biltong', 'potjiekos', 'chops'];
    final recipeId = recipeIds[index];
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 800;
    
    return InkWell(
      onTap: () => context.go('/recipe/$recipeId'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // Fixed height for mobile to prevent overflow
        height: isMobile ? 320 : null,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFFAFAFA)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isMobile ? _buildMobileRecipeCard(recipe) : _buildDesktopRecipeCard(recipe),
      ),
    );
  }

  Widget _buildMobileRecipeCard(Map<String, dynamic> recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section - smaller on mobile
        SizedBox(
          height: 140,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  recipe['image'],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time, size: 12, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        recipe['time'],
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D4D4D).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    recipe['difficulty'],
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content section - more compact
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['title'],
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF4D4D4D),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  recipe['description'],
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: const Color(0xFF666666),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                // Show only one tip on mobile
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D4D4D).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💡 ',
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          (recipe['tips'] as List<String>).first,
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            color: const Color(0xFF4D4D4D),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Tap to view more indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D4D4D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Tap to view recipe',
                    style: GoogleFonts.roboto(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopRecipeCard(Map<String, dynamic> recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  recipe['image'],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        recipe['time'],
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D4D4D).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    recipe['difficulty'],
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['title'],
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  recipe['description'],
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: const Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D4D4D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Pro Tips:',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: (recipe['tips'] as List<String>).take(2).map((tip) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF4D4D4D).withOpacity(0.2)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: const Color(0xFF4D4D4D),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              tip,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: const Color(0xFF4D4D4D),
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 