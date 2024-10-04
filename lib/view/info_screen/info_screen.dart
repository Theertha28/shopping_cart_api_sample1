import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api_sample1/controller/cart_screen_controller.dart';
import 'package:shopping_cart_api_sample1/controller/product_details_screen_controller.dart';
import 'package:shopping_cart_api_sample1/view/cart_screen/cart_screen.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key, required this.productId,
    });
   final String productId;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     context
     .read<ProductDetailsScreenController>().getProductDetails(widget.productId); 
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     final ProductDetailsScreenProvider = context.watch<ProductDetailsScreenController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        
        title: Center(
          child: Text("Details",
          style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.black),),
        ),
        actions: [
           Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27,vertical: 15),
                child: Stack(
                  children: [
                    Icon(Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 30,),
                  Positioned(
                    top: 3,
                    right: 4,
                    child:
                     CircleAvatar(
                      backgroundColor: Colors.black,
                  radius: 6,
                  child: Text("1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                    ),),),
                    ),
                  ],
                 ),
              )
        ],
      ),
      body: ProductDetailsScreenProvider.isLoading
      ?Center(child: CircularProgressIndicator(),)
      :Column(
        children: [
          Expanded(
            child: ListView(
              children:[
               Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Stack(
                    children: [
                      Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(ProductDetailsScreenProvider.productDetails?.image??"")
                          )
                        ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                       child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.favorite_border_outlined,color: Colors.black,),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                         
                        ),
                      ))
                 ]
                  ),
                  SizedBox(height: 20,),
                  Text("${ProductDetailsScreenProvider.productDetails?.title}",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.black,fontSize: 23),),
                  SizedBox(height: 8,),
                  RatingBar.readOnly(
                    filledIcon: Icons.star, 
                    emptyIcon: Icons.star_border,
                    initialRating: ProductDetailsScreenProvider.productDetails?.rating?.rate??0,
                    maxRating: 5,
                  ),
                   SizedBox(height: 8,),
                    Text("${ProductDetailsScreenProvider.productDetails?.rating?.rate}/5",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                      Text("(45 reviews)",style: TextStyle(color: Colors.grey.shade700,fontSize: 16)),
                  SizedBox(height: 20,),
                  Text("${ProductDetailsScreenProvider.productDetails?.description}",
                  style: TextStyle(color: Colors.grey,
                  fontSize: 16),textAlign: TextAlign.left,),
                  SizedBox(height: 20,),
                  Text("Choose Size",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17),),
                  SizedBox(height: 10,),
                  Row(children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:13,vertical: 12),
                      height: 40,
                      width: 40,
                      child: Text("S",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                       padding: EdgeInsets.symmetric(horizontal:13,vertical: 12),
                      height: 40,
                      width: 40,
                      child: Text("M",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)
                      ),),
                    SizedBox(width: 8,),
                    Container(
                       padding: EdgeInsets.symmetric(horizontal:13,vertical: 12),
                      height: 40,
                      width: 40,
                      child: Text("L",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)
                      ),),
                  ],)
                ],),
              ),
              ]
            ),
          ),
         
           Container(
            child:Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price",style: TextStyle(color: Colors.grey.shade700,fontSize: 15)),
                   SizedBox(height: 5,),
                    Text("${ProductDetailsScreenProvider.productDetails?.price}",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                  ],
                 ),
                   Padding(
                     padding: const EdgeInsets.all(15),
                     child: ElevatedButton(
                    
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20,horizontal: 20))
                        
                      ),
                      onPressed: (){
                     context.read<CartScreenController>().addProduct(
                      name: "${ProductDetailsScreenProvider.productDetails?.title}",
                      id: ProductDetailsScreenProvider.productDetails!.id!,
                      price:ProductDetailsScreenProvider.productDetails?.price?? 0 ,
                      desc: "${ProductDetailsScreenProvider.productDetails?.description}",
                      image: "${ProductDetailsScreenProvider.productDetails?.image}",
                      );

                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>CartScreen()));
                      },
                     child: Row(   
                                                    
                  mainAxisAlignment: MainAxisAlignment.center,
                       children: [  
                         Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                           SizedBox(width: 10,),              
                         Text("Add to Cart",
                         style: TextStyle(color: Colors.white),),
                        
                        
                       ],
                     )
                     ),
                   ),
                ],
              ),
            )
          
              ),
        ],
      ),
    );
  }
}