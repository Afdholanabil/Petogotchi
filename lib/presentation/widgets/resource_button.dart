// lib/presentation/widgets/resource_button.dart

import 'package:flutter/material.dart';

class ResourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int amount;
  final Color color;
  final VoidCallback onTap;

  ResourceButton({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all()
        
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min, // Pastikan Row mengambil ruang minimal
          children: [
            Text(
              '$amount',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(width: 4),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
