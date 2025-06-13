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
        'image': 'https://images.unsplash.com/photo-1591989330748-777649e84466?q=80&w=2333&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
        'image': 'https://images.unsplash.com/photo-1652209695374-7a91c243f12f?q=80&w=2630&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
      'potjiekos': {
        'title': 'Potjiekos Special',
        'description': 'A hearty potjie that\'ll feed the whole family',
        'time': '2-3 hours',
        'difficulty': 'Medium',
        'servings': '6-8 people',
        'image': 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'ingredients': [
          '1.5kg lamb or beef, cubed',
          '4 large onions, sliced',
          '4 large potatoes, cubed',
          '3 carrots, sliced',
          '2 cups beef stock',
          '2 tbsp oil',
          'Salt and pepper to taste',
          'Mixed herbs',
        ],
        'steps': [
          'Heat oil in the potjie pot over medium coals',
          'Brown the meat in batches - don\'t overcrowd the pot',
          'Remove meat and set aside',
          'Add onions to the pot and cook until soft and golden',
          'Return meat to the pot and add seasoning',
          'Add stock gradually - don\'t add too much at once',
          'Layer vegetables on top - potatoes first, then carrots',
          'Cover and simmer slowly for 2-3 hours',
          'Check occasionally but avoid stirring too much',
          'Vegetables should be tender when done',
          'Serve with bread or pap',
        ],
        'tips': [
          'Brown the meat first for maximum flavour',
          'Layer ingredients - don\'t stir too much',
          'Use a good cast iron potjie pot',
          'Low and slow is the way to go',
        ],
      },
      'chops': {
        'title': 'Braai Chops Perfection',
        'description': 'Juicy pork chops that\'ll make you the braai master',
        'time': '20 mins',
        'difficulty': 'Easy',
        'servings': '4 people',
        'image': 'https://images.unsplash.com/photo-1592686092916-672fa9e86866?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'ingredients': [
          '8 pork chops (about 2cm thick)',
          'Coarse salt',
          'Black pepper',
          '2 tbsp olive oil',
          'Garlic powder (optional)',
          'Rosemary sprigs (optional)',
        ],
        'steps': [
          'Remove chops from fridge 30 minutes before cooking',
          'Pat chops dry with paper towels',
          'Brush lightly with olive oil',
          'Season generously with coarse salt and black pepper',
          'Prepare braai - wait for hot coals with no flames',
          'Place chops on the braai grid over direct heat',
          'Sear for 3-4 minutes on first side - don\'t move them',
          'Flip once and sear the other side for 3-4 minutes',
          'Move to cooler part of braai if needed to finish cooking',
          'Cook until internal temperature reaches 63°C',
          'Rest for 5 minutes before serving',
          'Serve immediately with your favorite sides',
        ],
        'tips': [
          'Season well with coarse salt and pepper',
          'Let them come to room temperature first',
          'Don\'t move them too much - let them sear',
          'Rest for 5 minutes before serving',
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
      height: 400,
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            recipe['image'],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Back to Recipes',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['title'],
                    style: GoogleFonts.roboto(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe['description'],
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
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
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 40,
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Row(
          children: [
            Expanded(
              child: _buildInfoCard(Icons.access_time, 'Time', recipe['time']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoCard(Icons.bar_chart, 'Difficulty', recipe['difficulty']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoCard(Icons.people, 'Serves', recipe['servings']),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: const Color(0xFF4D4D4D),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: const Color(0xFF4D4D4D).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF4D4D4D),
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
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Ingredients',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4D4D4D),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: (recipe['ingredients'] as List<String>).asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4D4D4D),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: const Color(0xFF4D4D4D),
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
    );
  }

  Widget _buildStepsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: Row(
              children: [
                Text(
                  'Instructions',
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Tap to check off completed steps',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: const Color(0xFF4D4D4D).withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: (recipe['steps'] as List<String>).asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isCompleted = _completedSteps.contains(index);

              return FadeInUp(
                duration: Duration(milliseconds: 600 + (index * 100)),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isCompleted ? const Color(0xFF4D4D4D).withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCompleted ? const Color(0xFF4D4D4D) : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isCompleted ? const Color(0xFF4D4D4D) : const Color(0xFF4D4D4D).withOpacity(0.1),
                              shape: BoxShape.circle,
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
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF4D4D4D),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              step,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: isCompleted ? const Color(0xFF4D4D4D).withOpacity(0.7) : const Color(0xFF4D4D4D),
                                height: 1.5,
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
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Pro Tips',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4D4D4D),
              ),
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: MediaQuery.of(context).size.width > 800 ? 4.5 : 3.5,
            ),
            itemCount: (recipe['tips'] as List<String>).length,
            itemBuilder: (context, index) {
              return FadeInUp(
                duration: Duration(milliseconds: 800 + (index * 150)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4D4D4D).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: Color(0xFF4D4D4D),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          (recipe['tips'] as List<String>)[index],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: const Color(0xFF4D4D4D),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 