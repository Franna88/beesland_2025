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
              'Lekker Recipes & Braai Tips',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Make your braai legendary with our tried and tested recipes!',
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

  Widget _buildQuickTipsSection(BuildContext context) {
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
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 60,
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
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth > 1200) {
                crossAxisCount = 4;
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
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: crossAxisCount == 1 ? 3.5 : (crossAxisCount == 2 ? 2.2 : 1.1),
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
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
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
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Featured Recipes',
              style: GoogleFonts.roboto(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth > 1200) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

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
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe, int index, BuildContext context) {
    final recipeIds = ['boerewors', 'biltong', 'potjiekos', 'chops'];
    final recipeId = recipeIds[index];
    
    return InkWell(
      onTap: () => context.go('/recipe/$recipeId'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
      child: Column(
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
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.white,
                        ),
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
      ),
    ),
    );
  }
} 