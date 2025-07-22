import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;
  
  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final Set<int> _completedSteps = <int>{};
  late Map<String, dynamic> recipe;

  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  void _loadRecipe() {
    final recipes = {
      'boerewors': {
        'title': 'Perfect Boerewors Braai',
        'description': 'How to braai boerewors like a true South African',
        'time': '15 mins',
        'difficulty': 'Easy',
        'servings': '4-6 people',
        'image': 'images/meat_items/wors.jpg',
        'ingredients': [
          '1kg traditional boerewors',
          'Coarse salt',
          'Black pepper',
          'Pap ingredients (optional)',
          'Tomato sous (optional)',
        ],
        'steps': [
          'Prepare your braai fire and wait for the flames to die down - you want hot coals, not flames',
          'While waiting, take the boerewors out of the fridge to come to room temperature',
          'Season the boerewors lightly with coarse salt and black pepper',
          'Once coals are ready (white-hot with no flames), place boerewors on the braai grid',
          'Cook slowly over medium heat - don\'t rush it! This should take about 12-15 minutes',
          'Turn gently with tongs every 3-4 minutes - never use a fork as it will pierce the casing',
          'The boerewors is ready when it\'s golden brown all over and firm to touch',
          'Let it rest for 2-3 minutes before serving',
          'Serve with pap, sous, and a cold beer - enjoy!',
        ],
        'tips': [
          'Don\'t prick the wors - let the natural casing do its magic',
          'Braai slowly over medium coals',
          'Turn gently with tongs, not a fork',
          'Serve with pap, sous, and a cold Castle',
        ],
      },
      'biltong': {
        'title': 'Legendary Biltong Recipe',
        'description': 'Traditional biltong that\'ll make your ou toppie proud',
        'time': '5-7 days',
        'difficulty': 'Medium',
        'servings': '500g portions',
        'image': 'images/meat_items/biltong.jpg',
        'ingredients': [
          '2kg silverside or topside beef',
          '1 cup coarse salt',
          '2 tbsp coriander seeds, ground',
          '1 tbsp black pepper, ground',
          '2 cups brown vinegar',
          'Biltong spice (optional)',
        ],
        'steps': [
          'Cut the meat with the grain into strips about 2-3cm thick',
          'Mix salt, coriander, and pepper in a bowl',
          'Dip each strip in brown vinegar, then roll in the spice mixture',
          'Ensure all sides are well coated with spices',
          'Hang the strips on hooks in a well-ventilated, dry area',
          'Ensure good airflow - use a fan if necessary',
          'Allow to dry for 5-7 days depending on thickness and humidity',
          'Test by pressing - it should be firm but slightly give',
          'Store in brown paper bags in a cool, dry place',
        ],
        'tips': [
          'Use silverside or topside cuts',
          'Cut with the grain for proper texture',
          'Hang in a cool, dry place with good airflow',
          'Patience is key - don\'t rush the drying process',
        ],
      },
      'chicken-sosaties': {
        'title': 'Chicken Sosaties',
        'description': 'Juicy and flavorful chicken sosaties that will steal the show',
        'time': '30 mins',
        'difficulty': 'Medium',
        'servings': '4-6 people',
        'image': 'images/meat_items/chicken-sosaties.jpg',
        'ingredients': [
          '1kg chicken breast, cubed',
          'Bell peppers and onions',
          'Wooden skewers',
          'Marinade ingredients',
          'Fresh herbs',
        ],
        'steps': [
          'Soak wooden skewers in water for 30 minutes',
          'Cut chicken into even-sized cubes',
          'Prepare marinade and coat chicken pieces',
          'Cut vegetables into similar-sized pieces',
          'Thread chicken and vegetables onto skewers',
          'Preheat braai to medium-high heat',
          'Grill sosaties for 12-15 minutes, turning occasionally',
          'Baste with remaining marinade while cooking',
          'Ensure chicken is cooked through before serving',
        ],
        'tips': [
          'Marinate overnight for best results',
          'Don\'t overcrowd the skewers',
          'Keep basting with the marinade',
          'Serve with fresh lemon wedges',
        ],
      },
      'lamb-chops': {
        'title': 'Perfect Lamb Chops',
        'description': 'Tender and succulent lamb chops with a perfect crust',
        'time': '20 mins',
        'difficulty': 'Medium',
        'servings': '4 people',
        'image': 'images/meat_items/lamb-chops.jpg',
        'ingredients': [
          '8 lamb chops',
          'Fresh rosemary and thyme',
          'Garlic cloves',
          'Olive oil',
          'Salt and black pepper',
        ],
        'steps': [
          'Remove chops from fridge 30 minutes before cooking',
          'Mix herbs, garlic, and oil for marinade',
          'Season chops generously with salt and pepper',
          'Rub herb mixture onto both sides of chops',
          'Prepare braai for medium-high heat',
          'Grill chops for 4-5 minutes per side for medium',
          'Let rest for 5-10 minutes before serving',
          'Garnish with fresh herbs',
        ],
        'tips': [
          'Bring to room temperature before cooking',
          'Season generously with herbs and garlic',
          'Cook on high heat for a good crust',
          'Rest for 5-10 minutes before serving',
        ],
      },
    };

    recipe = recipes[widget.recipeId] ?? recipes['boerewors']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeroSection(context),
            _buildRecipeInfo(context),
            _buildIngredients(context),
            _buildStepsSection(context),
            _buildTipsSection(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              recipe['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: FadeInLeft(
              duration: const Duration(milliseconds: 600),
              child: InkWell(
                onTap: () => context.go('/recipes'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Back to Recipes',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            right: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECIPE',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recipe['title'],
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recipe['description'],
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.6,
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

  Widget _buildRecipeInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
        vertical: 60,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: [
            _buildInfoCard(Icons.access_time, 'Time', recipe['time']),
            _buildInfoCard(Icons.bar_chart, 'Difficulty', recipe['difficulty']),
            _buildInfoCard(Icons.people, 'Serves', recipe['servings']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(24),
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
              color: const Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C2C2C),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: AssetImage(recipe['image']),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'INGREDIENTS',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'What You\'ll Need',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
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
                      children: (recipe['ingredients'] as List<String>).asMap().entries.map((entry) {
                        final index = entry.key;
                        return Padding(
                          padding: EdgeInsets.only(bottom: index < (recipe['ingredients'] as List).length - 1 ? 24 : 0),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'INSTRUCTIONS',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                color: const Color(0xFF2C2C2C),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FadeInLeft(
            duration: const Duration(milliseconds: 800),
            child: Row(
              children: [
                Text(
                  'Step by Step Guide',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C2C2C),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Tap to mark as complete',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xFF2C2C2C).withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Column(
            children: (recipe['steps'] as List<String>).asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isCompleted = _completedSteps.contains(index);

              return FadeInUp(
                duration: Duration(milliseconds: 1000 + (index * 100)),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isCompleted) {
                          _completedSteps.remove(index);
                        } else {
                          _completedSteps.add(index);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isCompleted ? const Color(0xFF2C2C2C).withOpacity(0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCompleted ? const Color(0xFF2C2C2C) : Colors.black.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 10),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isCompleted ? const Color(0xFF2C2C2C) : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isCompleted ? Colors.transparent : const Color(0xFF2C2C2C),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF2C2C2C),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              step,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                height: 1.6,
                                color: isCompleted 
                                    ? const Color(0xFF2C2C2C).withOpacity(0.5) 
                                    : const Color(0xFF2C2C2C),
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
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
        ],
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: AssetImage(recipe['image']),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'PRO TIPS',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'Expert Advice',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  children: (recipe['tips'] as List<String>).asMap().entries.map((entry) {
                    final index = entry.key;
                    return FadeInUp(
                      duration: Duration(milliseconds: 1000 + (index * 150)),
                      child: Container(
                        width: MediaQuery.of(context).size.width > 800 ? (MediaQuery.of(context).size.width - 78) / 2 : MediaQuery.of(context).size.width - 48,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.lightbulb_outline,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 