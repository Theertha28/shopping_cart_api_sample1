import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopping_cart_api_sample1/view/home_screen/home_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                  "https://images.pexels.com/photos/26563051/pexels-photo-26563051/free-photo-of-t-shirts-and-lamp.jpeg?auto=compress&cs=tinysrgb&w=400"))
              ),
              
            ),
          ),
          Container(
          padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 18))
                    
                  ),
                  onPressed: (){
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>HomeScreen()));
                },
                 child: Row(                                 
                mainAxisAlignment: MainAxisAlignment.center,
                   children: [                  
                     Text("Get Started",
                     style: TextStyle(color: Colors.white),),
                     SizedBox(width: 10,),
                     Icon(Icons.arrow_forward,color: Colors.white,)
                   ],
                 )
                 ),
              ),
        ],
      ),
    );
  }
}