import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? image;
  @HiveField(3)
  int? qty;
  @HiveField(4)
  double? price;
  @HiveField(5)
  String? desc;

  CartModel({
    this.id,
    this.image,
    this.title,
    this.qty,
    this.desc,
    this.price,
  });
}