import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api_sample1/controller/home_screen_controller.dart';
import 'package:shopping_cart_api_sample1/view/cart_screen/cart_screen.dart';
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Discover",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
          ),
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black,
                      size: 34,
                    ),
                    Positioned(
                      top: 3,
                      right: 4,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 6,
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body: screenProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
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
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Search anything",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.filter_list_outlined,
                          color: Colors.white,
                        ),
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
                      children: List.generate(
                        screenProvider.categoryList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
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
                                    color:
                                        screenProvider.selectedCategoryIndex ==
                                                index
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: screenProvider.isProductsLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemCount: screenProvider.product.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 250,
                                  crossAxisSpacing: 15),
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InfoScreen(
                                                productId: screenProvider
                                                    .product[index].id
                                                    .toString(),
                                              )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Stack(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      screenProvider
                                                          .product[index].image
                                                          .toString()))),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              child: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.black,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ))
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      screenProvider.product[index].title
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      screenProvider.product[index].price
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              )),
                )
              ],
            ),
    );
  }
}
