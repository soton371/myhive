import 'package:hive/hive.dart';
part 'recipient_mod.g.dart';
@HiveType(typeId: 0)
class RecipientModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String number;

  RecipientModel({required this.name, required this.number});
}
