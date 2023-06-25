import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'record.g.dart';

@HiveType(typeId: 0)
class Record {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String id;

  Record({
    required this.name,
    required this.amount,
    required this.date,
    required this.id,
  });
}
