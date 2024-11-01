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
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4), // Sesuaikan padding
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Membatasi ukuran Row agar sesuai
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10, // Dikurangi ukuran font
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis, // Memotong teks jika terlalu panjang
            ),
          ),
          SizedBox(width: 2), // Sesuaikan spasi
          Icon(icon, color: color, size: 14), // Dikurangi ukuran ikon
        ],
      ),
    );
  }
}
