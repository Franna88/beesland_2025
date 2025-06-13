import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../services/cart_service.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isMenuOpen = false;
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartUpdated);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartUpdated);
    super.dispose();
  }

  void _onCartUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF4D4D4D),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildDesktopNav(context);
          } else {
            return _buildMobileNav(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
          children: [
            _buildNavLink('Home', '/'),
            _buildNavLink('Vleis & Products', '/products'),
            _buildNavLink('About Us', '/about'),
            _buildNavLink('Recipes & Tips', '/recipes'),
            _buildNavLink('Specials', '/promotions'),
            _buildNavLink('Holla at Us', '/contact'),
            const SizedBox(width: 16),
            _buildCartIcon(),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(context),
            IconButton(
              icon: Icon(
                _isMenuOpen ? Icons.close : Icons.menu,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  _isMenuOpen = !_isMenuOpen;
                });
              },
            ),
          ],
        ),
        if (_isMenuOpen) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildMobileNavLink('Home', '/'),
                _buildMobileNavLink('Vleis & Products', '/products'),
                _buildMobileNavLink('About Us', '/about'),
                              _buildMobileNavLink('Recipes & Tips', '/recipes'),
              _buildMobileNavLink('Specials', '/promotions'),
              _buildMobileNavLink('Holla at Us', '/contact'),
              _buildMobileCartLink(),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/'),
      child:         Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/beesland_logo.jpg',
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.store,
                  color: Colors.white,
                  size: 32,
                );
              },
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Beesland',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Slaghuis & Deli',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget _buildNavLink(String title, String route) {
    final isActive = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path == route;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () => context.go(route),
        style: TextButton.styleFrom(
          foregroundColor: isActive ? Colors.white : Colors.white.withOpacity(0.8),
          backgroundColor: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(String title, String route) {
    final isActive = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path == route;
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: TextButton(
        onPressed: () {
          context.go(route);
          setState(() {
            _isMenuOpen = false;
          });
        },
        style: TextButton.styleFrom(
          foregroundColor: isActive ? Colors.white : const Color(0xFF4D4D4D),
          backgroundColor: isActive ? const Color(0xFF4D4D4D) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCartIcon() {
    return InkWell(
      onTap: () => context.go('/cart'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 24,
            ),
            if (_cartService.itemCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${_cartService.itemCount}',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
             ),
     );
   }

  Widget _buildMobileCartLink() {
    final isActive = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path == '/cart';
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: TextButton(
        onPressed: () {
          context.go('/cart');
          setState(() {
            _isMenuOpen = false;
          });
        },
        style: TextButton.styleFrom(
          foregroundColor: isActive ? Colors.white : const Color(0xFF4D4D4D),
          backgroundColor: isActive ? const Color(0xFF4D4D4D) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          children: [
            const Icon(Icons.shopping_cart, size: 20),
            const SizedBox(width: 8),
            Text(
              'Cart',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (_cartService.itemCount > 0) ...[
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_cartService.itemCount}',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 