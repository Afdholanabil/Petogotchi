// lib/presentation/widgets/pet_button.dart
import 'package:flutter/material.dart';
import 'package:learn_1/domain/entities/pet.dart';

class PetButton extends StatelessWidget {
  final Pet pet;
  final bool isSelected;

  PetButton({required this.pet, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepPurple : Colors.purple[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: Row(
          children: [
            Image.asset(
              pet.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'H: ${pet.energy}',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Text(
                  'C: ${pet.cleanliness}',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Text(
                  'Hap: ${pet.happiness}',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
