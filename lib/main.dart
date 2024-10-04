import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api_sample1/controller/cart_screen_controller.dart';
import 'package:shopping_cart_api_sample1/controller/home_screen_controller.dart';
import 'package:shopping_cart_api_sample1/controller/product_details_screen_controller.dart';
import 'package:shopping_cart_api_sample1/model/cart_model.dart';
import 'package:shopping_cart_api_sample1/view/login_screen/login_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter(); //hive step 1
   Hive.registerAdapter(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>HomeScreenController()),
        ChangeNotifierProvider(create: (context)=>ProductDetailsScreenController()),
        ChangeNotifierProvider(create: (context)=>CartScreenController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}