import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_cart_api_sample1/model/cart_model.dart';

class CartScreenController with ChangeNotifier{
  final cartbox= Hive.box<CartModel>("cartBox");
 List<CartModel> cart=[]; 
 List keys=[];
  
  void addProduct(
    {required String name,
    String? image,
    String? desc,
    required int id,
    String? title,
    required double price
    }
  ){
  cartbox.add (CartModel(
    id: id,
   image: image,
   title: title,
   qty: 1,
   desc: desc,
   price: price));
  
  keys=cartbox.keys.toList();
  }
  void getProducts(){}
  void removeProducts(){}
  void incrementQty(){}
  void decrementQty(){}

}