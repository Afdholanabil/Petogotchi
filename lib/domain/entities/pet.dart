// lib/domain/entities/pet.dart

class Pet {
  String name;
  String image;
  int energy;
  int cleanliness;
  int happiness;
  bool ringsClosed;
  DateTime? ringsClosedTime;
  String environment; // Menambahkan environment

  Pet({
    required this.name,
    required this.image,
    this.energy = 50,
    this.cleanliness = 50,
    this.happiness = 50,
    this.ringsClosed = false,
    this.ringsClosedTime,
    this.environment = 'Home', // Default environment
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
