import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_api_sample1/model/products_screen_model.dart';
  
class ProductDetailsScreenController with ChangeNotifier{
   ProductScreenModel? productDetails;
    bool isLoading=false;
  Future<void> getProductDetails(String productId) async {
      isLoading=true;
    notifyListeners();
    final url=Uri.parse("https://fakestoreapi.com/products/$productId");
    try{
 var res= await http.get(url);
 if(res.statusCode==200){
  productDetails=productModelFromJson(res.body);
 }
    }catch(e){
    print(e);
    }
     isLoading=false;
    notifyListeners();
  }
}