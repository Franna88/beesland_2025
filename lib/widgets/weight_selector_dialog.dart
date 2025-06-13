import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeightSelectorDialog extends StatefulWidget {
  final String productName;
  final String price;
  final double initialWeight;
  final Function(double weight) onWeightSelected;

  const WeightSelectorDialog({
    super.key,
    required this.productName,
    required this.price,
    required this.initialWeight,
    required this.onWeightSelected,
  });

  @override
  State<WeightSelectorDialog> createState() => _WeightSelectorDialogState();
}

class _WeightSelectorDialogState extends State<WeightSelectorDialog> {
  late double _selectedWeight;
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedWeight = widget.initialWeight;
    _weightController.text = _selectedWeight.toString();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  double get _pricePerKg {
    final regex = RegExp(r'R(\d+)');
    final match = regex.firstMatch(widget.price);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 0.0;
  }

  double get _totalPrice => _pricePerKg * _selectedWeight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Select Weight',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF4D4D4D),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productName,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.price,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: const Color(0xFF4D4D4D).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Weight (kg)',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 12),
          // Quick selection buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [0.5, 1.0, 1.5, 2.0, 2.5, 3.0].map((weight) {
              final isSelected = _selectedWeight == weight;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedWeight = weight;
                    _weightController.text = weight.toString();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4D4D4D) : Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFF4D4D4D),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${weight}kg',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF4D4D4D),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Custom weight input
          TextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Custom weight (kg)',
              hintText: 'Enter weight in kg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: const Color(0xFF4D4D4D).withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF4D4D4D), width: 2),
              ),
            ),
            onChanged: (value) {
              final weight = double.tryParse(value);
              if (weight != null && weight > 0) {
                setState(() {
                  _selectedWeight = weight;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Price calculation
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Calculation',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'R${_pricePerKg.toStringAsFixed(2)}/kg × ${_selectedWeight}kg = R${_totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4D4D4D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.roboto(
              color: const Color(0xFF4D4D4D),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _selectedWeight > 0 ? () {
            widget.onWeightSelected(_selectedWeight);
            Navigator.of(context).pop();
          } : null,
          child: Text(
            'Add to Cart',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
} 