// lib/domain/entities/resource.dart
class Resource {
  final String name;
  final int cost;
  final String type; // 'food', 'grooming', 'play'

  Resource({
    required this.name,
    required this.cost,
    required this.type,
  });
}
