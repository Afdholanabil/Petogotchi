// lib/domain/entities/pet.dart

class Pet {
  String name;
  String image;
  int energy;
  int cleanliness;
  int happiness;
  bool ringsClosed;
  DateTime? ringsClosedTime;
  String environment;
  String typeResource; // Tambahkan properti ini

  Pet({
    required this.name,
    required this.image,
    this.energy = 100,
    this.cleanliness = 100,
    this.happiness = 100,
    this.ringsClosed = false,
    this.ringsClosedTime,
    this.environment = 'Home',
    this.typeResource = 'food', // Default resource type
  });

  void feed() {
    energy = (energy + 10).clamp(0, 100);
    happiness = (happiness + 5).clamp(0, 100);
  }

  void groom() {
    cleanliness = (cleanliness + 10).clamp(0, 100);
    happiness = (happiness + 5).clamp(0, 100);
  }

  void play() {
    happiness = (happiness + 10).clamp(0, 100);
    energy = (energy - 5).clamp(0, 100);
  }
}
