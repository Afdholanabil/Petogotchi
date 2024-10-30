// lib/data/models/pet_model.dart

import '../../domain/entities/pet.dart';

class PetModel extends Pet {
  PetModel({
    required String name,
    required String image,
    int energy = 50,
    int cleanliness = 50,
    int happiness = 50,
    bool ringsClosed = false,
    DateTime? ringsClosedTime,
    String environment = 'Home', // Default environment
  }) : super(
          name: name,
          image: image,
          energy: energy,
          cleanliness: cleanliness,
          happiness: happiness,
          ringsClosed: ringsClosed,
          ringsClosedTime: ringsClosedTime,
          environment: environment,
        );

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      name: json['name'],
      image: json['image'],
      energy: json['energy'],
      cleanliness: json['cleanliness'],
      happiness: json['happiness'],
      ringsClosed: json['ringsClosed'],
      ringsClosedTime: json['ringsClosedTime'] != null
          ? DateTime.parse(json['ringsClosedTime'])
          : null,
      environment: json['environment'] ?? 'Home',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'energy': energy,
      'cleanliness': cleanliness,
      'happiness': happiness,
      'ringsClosed': ringsClosed,
      'ringsClosedTime': ringsClosedTime?.toIso8601String(),
      'environment': environment,
    };
  }
}
