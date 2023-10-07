import 'package:hive/hive.dart';

// part 'api_model.g.dart';

@HiveType(typeId: 0)
class ApiModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;
  // @HiveField(1)
  // final String name;

  ApiModel({
    required this.id,
    required this.name,
    // Add other fields as needed
  });
}
