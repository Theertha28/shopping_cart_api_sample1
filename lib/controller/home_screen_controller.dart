import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_api_sample1/model/products_screen_model.dart';

class HomeScreenController with ChangeNotifier{
  List <ProductScreenModel> product=[];
  int selectedCategoryIndex=0;
  bool isLoading=false;
  bool isProductsLoading=false;

   List categoryList=["All"];
 
  Future<void> getCategory() async {
    isLoading=true;
    notifyListeners();
    final url= Uri.parse(
      "https://fakestoreapi.com/products/categories");
      try{
        var response= await http.get(url);
        if(response.statusCode == 200){
         categoryList.addAll(  jsonDecode(response.body));
       
         
        }
      }catch(e){
        print(e);
      }
      isLoading=false;
      notifyListeners();
  }

  void onCategorySelection(int index){
  selectedCategoryIndex=index;
  notifyListeners();
  if(selectedCategoryIndex==0){
    getAllProducts();
  }else{
    getProductsByCategory(categoryList[selectedCategoryIndex]);
  }
  }

   Future<void> getAllProducts() async {
   
    isProductsLoading=true;
     notifyListeners();
    final url= Uri.parse(
      "https://fakestoreapi.com/products");
      try{
        var response= await http.get(url);
        if(response.statusCode == 200){
         product= productScreenModelFromJson(response.body);
        }
      }catch(e){
        print(e);
      }
     
      isProductsLoading=false;
     notifyListeners();
  }
  
  Future<void> getProductsByCategory(String Category) async {
  
    isProductsLoading=true;
     notifyListeners();
    final url= Uri.parse(
      "https://fakestoreapi.com/products/category/$Category");
      try{
        var response= await http.get(url);
        if(response.statusCode == 200){
         product= productScreenModelFromJson(response.body);
        }
      }catch(e){
        print(e);
      }
     
      isProductsLoading=false;
     notifyListeners();
  }
  


}