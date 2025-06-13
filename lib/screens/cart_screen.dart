import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import '../widgets/weight_selector_dialog.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeader(),
            _cartService.items.isEmpty
                ? _buildEmptyCart()
                : _buildCartContent(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
              'Your Cart',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              _cartService.items.isEmpty
                  ? 'Your cart is empty - let\'s fill it with some lekker vleis!'
                  : 'Review your order before proceeding to checkout',
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

  Widget _buildEmptyCart() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Column(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: const Color(0xFF4D4D4D).withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4D4D4D),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Browse our selection of premium vleis and add some lekker items to your cart!',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/products'),
              child: const Text('Browse Our Vleis'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 40,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _buildCartItems(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: _buildOrderSummary(),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _buildCartItems(),
                const SizedBox(height: 32),
                _buildOrderSummary(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCartItems() {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cart Items (${_cartService.itemCount})',
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cartService.items.length,
            itemBuilder: (context, index) {
              final item = _cartService.items[index];
              return _buildCartItemCard(item, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item, int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 600 + (index * 100)),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4D4D4D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.category,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: const Color(0xFF4D4D4D).withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${item.price} × ${item.weight}kg',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4D4D4D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total: R${item.totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  // Quantity controls
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (item.quantity > 1) {
                            _cartService.updateQuantity(item.id, item.quantity - 1);
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: const Color(0xFF4D4D4D),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '${item.quantity}',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4D4D4D),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _cartService.updateQuantity(item.id, item.quantity + 1);
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: const Color(0xFF4D4D4D),
                      ),
                    ],
                  ),
                  // Weight edit button
                  TextButton.icon(
                    onPressed: () => _editWeight(item),
                    icon: const Icon(Icons.scale, size: 16),
                    label: Text(
                      '${item.weight}kg',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF4D4D4D),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ),
                  // Remove button
                  TextButton(
                    onPressed: () {
                      _cartService.removeItem(item.id);
                    },
                    child: Text(
                      'Remove',
                      style: GoogleFonts.roboto(
                        color: Colors.red[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4D4D4D),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items (${_cartService.itemCount})',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                  Text(
                    'R${_cartService.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                  Text(
                    'R${_cartService.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/order'),
                  child: const Text('Proceed to Order'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/products'),
                  child: const Text('Continue Shopping'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editWeight(CartItem item) {
    showDialog(
      context: context,
      builder: (context) => WeightSelectorDialog(
        productName: item.name,
        price: item.price,
        initialWeight: item.weight,
        onWeightSelected: (weight) {
          _cartService.updateWeight(item.id, weight);
        },
      ),
    );
  }
} 