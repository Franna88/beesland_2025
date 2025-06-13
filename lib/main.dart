import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/about_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/promotions_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
import 'screens/recipe_detail_screen.dart';

void main() {
  runApp(const BeeslandApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/recipes',
      builder: (context, state) => const RecipesScreen(),
    ),
    GoRoute(
      path: '/promotions',
      builder: (context, state) => const PromotionsScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/order',
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: '/recipe/:recipeId',
      builder: (context, state) {
        final recipeId = state.pathParameters['recipeId']!;
        return RecipeDetailScreen(recipeId: recipeId);
      },
    ),
  ],
);

class BeeslandApp extends StatelessWidget {
  const BeeslandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Beesland Slaghuis & Deli',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4D4D4D),
          brightness: Brightness.light,
          primary: const Color(0xFF4D4D4D),
          secondary: const Color(0xFF4D4D4D),
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF4D4D4D),
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: const Color(0xFF4D4D4D),
          displayColor: const Color(0xFF4D4D4D),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF4D4D4D),
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4D4D4D),
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF4D4D4D),
            side: const BorderSide(color: Color(0xFF4D4D4D), width: 2),
            textStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}

