// lib/presentation/widgets/currency_button.dart
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  CurrencyButton({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 4),
          Icon(icon, color: color),
        ],
      ),
    );
  }
}
