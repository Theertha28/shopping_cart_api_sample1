
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api_sample1/controller/home_screen_controller.dart';
import 'package:shopping_cart_api_sample1/view/info_screen/info_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback(
    (timeStamp) async {
     await context.read<HomeScreenController>().getCategory();
     await context.read<HomeScreenController>().getAllProducts();
    },
   );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
     final screenProvider = context.watch<HomeScreenController>();
//  List myDataList = [
//   {
//     "itemName": "Women Round Neck T-Shirt",
//     "imageUrl": "https://images.pexels.com/photos/21926926/pexels-photo-21926926/free-photo-of-portrait-of-woman-in-t-shirt.jpeg?auto=compress&cs=tinysrgb&w=400",
//     "price": "PKR 1,399",
//   },
//   {
//     "itemName": "Women Printed Casual T-Shirt",
//     "imageUrl": "https://images.pexels.com/photos/21926932/pexels-photo-21926932/free-photo-of-portrait-of-woman-in-t-shirt.jpeg?auto=compress&cs=tinysrgb&w=400",
//     "price": "PKR 1,268",
//   },
//   {
//     "itemName": "Roadster Round Neck T-Shirt",
//     "imageUrl": "https://images.pexels.com/photos/9558935/pexels-photo-9558935.jpeg?auto=compress&cs=tinysrgb&w=400",
//     "price": "PKR 1,799",
//   },
//   {
//     "itemName": "Solid Men Casual T-Shirt",
//     "imageUrl": "https://images.pexels.com/photos/9558260/pexels-photo-9558260.jpeg?auto=compress&cs=tinysrgb&w=400",
//     "price": "PKR 1,999",
//   },
//   {
//     "itemName": "Women's Long Sleeve Crop ",
//     "imageUrl": "https://tse4.mm.bing.net/th?id=OIP.fH8jzH23jVhNX-qCLMHF9AHaKL&pid=Api&P=0&h=180",
//     "price": "PKR 1,290",
//   },
//   {
//     "itemName": "Women's Plain Crop T-Shirt",
//     "imageUrl": "https://tse2.mm.bing.net/th?id=OIP.TB8w0xzwEyFPYLeuc5VADAHaJo&pid=Api&P=0&h=180",
//     "price": "PKR 1,690",
//   },
//   {
//     "itemName": "Women's Floral Print Crop Tee",
//     "imageUrl": "https://tse1.mm.bing.net/th?id=OIP.6EDJjfW_-HrJMgos3BiYEgHaJ4&pid=Api&P=0&h=180",
//     "price": "PKR 998",
//   },
//   {
//     "itemName": "Women's Off-Shoulder T-Shirt",
//     "imageUrl": "https://tse3.mm.bing.net/th?id=OIP.aKQ5dtKQnsw_pVeMeGSmXgAAAA&pid=Api&P=0&h=180",
//     "price": "PKR 1,673",
//   },
//   {
//     "itemName": "Women's Polka Dot Crop Tee",
//     "imageUrl": "https://tse3.mm.bing.net/th?id=OIP.VM_F3b9TAPtnyfoESUldzgHaJ4&pid=Api&P=0&h=180",
//     "price": "PKR 1,234",
//   },
//   {
//     "itemName": "Women's Classic Crop T-Shirt",
//     "imageUrl": "https://tse1.mm.bing.net/th?id=OIP.63Nd4FhFTGr52Gt736DMewHaJ4&pid=Api&P=0&h=180",
//     "price": "PKR 1,874",
//   },
// ];



    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Discover",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,color: Colors.black
              ),
              ),
          ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 18),
                child: Stack(
                  children: [
                    Icon(Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 34,),
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
            body: screenProvider.isLoading
            ? Center(
             child:CircularProgressIndicator(),
            )
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(height: 10,),
                         Expanded(
                           child: Container(
                            
                           padding: EdgeInsets.symmetric(horizontal: 20),
                           height: 50,
                             decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: Colors.grey.shade300,
                             ),
                             
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Icon(Icons.search,
                                    color: Colors.black,
                                     ),
                                     SizedBox(width: 10,),
                                  Text("Search anything",
                                    style: TextStyle(color: Colors.grey,
                                    fontSize: 20),),
                                  
                                ],
                              ),
                            ),
                          ),
                         ),
                         SizedBox(width: 10,),
                         Container(
                          height: 50,  
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.filter_list_outlined,
                          color: Colors.white,),
                         ),
                      
                    ],
                  ),
                ),
               
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:List.generate(
                        screenProvider.categoryList.length,
                         (index)=> Padding(
                           padding: const EdgeInsets.all(8.0),
                           child:InkWell(
                      onTap: () {
                        context
                            .read<HomeScreenController>()
                            .onCategorySelection(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: screenProvider.selectedCategoryIndex ==
                                    index
                                ? Colors.black
                                : Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          screenProvider.categoryList[index].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: screenProvider.selectedCategoryIndex ==
                                      index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                         ),),
                     
                    ),
                  ),
                ),
                

              Expanded(
                
                child: screenProvider.isProductsLoading
                ?Center(child: CircularProgressIndicator(),)
               : GridView.builder(
                  itemCount: screenProvider.product.length,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  gridDelegate:
                 SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 15),
                   itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context,
                       MaterialPageRoute(builder: (context) =>InfoScreen(
                       productId: screenProvider.product[index].id.toString(),
                       ) )
                       );
                    },
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Expanded(
                            child: Stack(
                              children:[ Container(
                                decoration: BoxDecoration(
                                   color: Colors.grey,
                                   borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                    screenProvider.product[index].image.toString()))
                                ),
                              
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                height: 38,
                                width: 38,
                                child: Icon(Icons.favorite_border_outlined,color: Colors.black,),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ))
                              ]
                            ),
                          ),
                          SizedBox(height: 11,),
                         
                        Text(screenProvider.product[index].title.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 14,
                          color: Colors.black),),
                        SizedBox(height: 8,),
                        Text(screenProvider.product[index].price.toString(),
                        style: TextStyle(
                         fontSize: 11,
                          color: Colors.grey.shade600),),
                      ],
                     ),
                   )
                   ),
              )
                  
              ],
            ),

            );
    
  }
}