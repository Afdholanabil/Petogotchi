// lib/presentation/widgets/resource_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../../data/models/resource_model.dart';
import '../../domain/entities/resource_data.dart';

class ResourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int amount;
  final Color color;
  final String resourceType;
  final int cost;
  final double? width;

  ResourceButton(
      {required this.icon,
      required this.label,
      required this.amount,
      required this.color,
      required this.resourceType,
      required this.cost,
      this.width});

  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Draggable<ResourceData>(
      data: ResourceData(resourceType: resourceType, amount: 1),
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: _buildDraggedButton(amount: 1),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildButtonContent(),
      ),
      child: SizedBox(
        // Menggunakan width yang diteruskan atau fleksibel
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            gameController.buyResourceAction(
              ResourceModel(
                name: label,
                cost: cost,
                type: resourceType,
              ),
            );
          },
          child: _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$amount ',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Icon(icon, color: Colors.white, size: 24),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$cost',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            SizedBox(width: 4),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.attach_money,
                  size: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

 Widget _buildDraggedButton({required int amount}) {
  return Transform.translate(
    offset: Offset(-80, -50), // Sesuaikan nilai offset sesuai kebutuhan
    child: Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '+$amount',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6),
            Icon(icon, color: Colors.white, size: 24),
          ],
        ),
      ),
    ),
  );
}

  int _getResourceCost(String resourceType) {
    switch (resourceType) {
      case 'food':
        return 10;
      case 'grooming':
        return 15;
      case 'play':
        return 20;
      default:
        return 10;
    }
  }
}
