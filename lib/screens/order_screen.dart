import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CartService _cartService = CartService();
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  
  String _selectedCollectionTime = 'ASAP';
  bool _isSubmitting = false;

  final List<String> _collectionTimes = [
    'ASAP',
    'Within 1 hour',
    'Within 2 hours',
    'Tomorrow morning',
    'Tomorrow afternoon',
    'Specific time (call to arrange)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cartService.items.isEmpty) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(),
              _buildEmptyCartMessage(),
              const FooterWidget(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeader(),
            _buildOrderForm(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCartMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 120,
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
              'No items to order',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4D4D4D),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add some lekker vleis to your cart first!',
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
              'Place Your Order',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Fill in your details and we\'ll have your order ready for collection!',
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

  Widget _buildOrderForm() {
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
                  flex: 6,
                  child: _buildCustomerForm(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 4,
                  child: _buildOrderSummary(),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _buildCustomerForm(),
                const SizedBox(height: 32),
                _buildOrderSummary(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCustomerForm() {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Details',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4D4D4D),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: 'Enter your phone number',
              icon: Icons.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'Enter your email address',
              icon: Icons.email,
              isRequired: false,
            ),
            const SizedBox(height: 24),
            Text(
              'Collection Time',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4D4D4D),
              ),
            ),
            const SizedBox(height: 12),
            _buildCollectionTimeSelector(),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _notesController,
              label: 'Special Instructions (Optional)',
              hint: 'Any special requests or notes...',
              icon: Icons.note,
              isRequired: false,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = true,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF4D4D4D)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: const Color(0xFF4D4D4D).withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4D4D4D), width: 2),
            ),
          ),
          validator: isRequired ? (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $label';
            }
            return null;
          } : null,
        ),
      ],
    );
  }

  Widget _buildCollectionTimeSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4D4D4D).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: _collectionTimes.map((time) {
          return RadioListTile<String>(
            title: Text(
              time,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: const Color(0xFF4D4D4D),
              ),
            ),
            value: time,
            groupValue: _selectedCollectionTime,
            onChanged: (value) {
              setState(() {
                _selectedCollectionTime = value!;
              });
            },
            activeColor: const Color(0xFF4D4D4D),
          );
        }).toList(),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cartService.items.length,
                itemBuilder: (context, index) {
                  final item = _cartService.items[index];
                  return _buildOrderItem(item);
                },
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
                  onPressed: _isSubmitting ? null : _submitOrder,
                  child: _isSubmitting
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Placing Order...'),
                          ],
                        )
                      : const Text('Place Order'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/cart'),
                  child: const Text('Back to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              item.image,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
                Text(
                  '${item.quantity}x ${item.weight}kg @ ${item.price}',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: const Color(0xFF4D4D4D).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'R${item.totalPrice.toStringAsFixed(2)}',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4D4D4D),
            ),
          ),
        ],
      ),
    );
  }

  void _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate order processing
    await Future.delayed(const Duration(seconds: 2));

    // Generate order number
    final orderNumber = 'BL${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

    // Clear cart
    _cartService.clearCart();

    setState(() {
      _isSubmitting = false;
    });

    // Show success dialog
    if (mounted) {
      _showOrderConfirmation(orderNumber);
    }
  }

  void _showOrderConfirmation(String orderNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green[600],
            ),
            const SizedBox(height: 16),
            Text(
              'Order Placed Successfully!',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Order Number: $orderNumber',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Collection: $_selectedCollectionTime',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'We\'ll call you when your order is ready for collection. Thanks for choosing Beesland!',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/');
              },
              child: const Text('Back to Home'),
            ),
          ),
        ],
      ),
    );
  }
} 