import '../../domain/entities/resource.dart';

class ResourceModel extends Resource {
  ResourceModel({
    required String name,
    required int cost,
    required String type,
  }) : super(
          name: name,
          cost: cost,
          type: type,
        );

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      name: json['name'],
      cost: json['cost'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'type': type,
    };
  }
}
