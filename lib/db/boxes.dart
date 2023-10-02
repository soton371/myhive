import 'package:hive/hive.dart';
import 'package:myhive/models/recipient_mod.dart';

class Boxes{
  static Box<RecipientModel> getData() => Hive.box<RecipientModel>('recipient');
}