import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_cart_api_sample1/controller/cart_screen_controller.dart';
import 'package:shopping_cart_api_sample1/view/widgets/cart_item_widget.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
    context.read<CartScreenController>().getProducts();
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 final providerObj=context.watch<CartScreenController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          title: providerObj.cart[index].name.toString(),
                          desc: providerObj.cart[index].desc.toString(),
                          qty: providerObj.cart[index].qty.toString(),
                          price:providerObj.cart[index].price.toString(),
                          image:
                              providerObj.cart[index].image.toString(),
                          onIncrement: () {
                            context.read<CartScreenController>().incrementQty(index);
                          },
                          onDecrement: () {
                              context.read<CartScreenController>().decrementQty(index);
                          },
                          onRemove: () {
                            context.read<CartScreenController>().removeProcuct(index);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 15),
                      itemCount: providerObj.cart.length),
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
                    Text(providerObj.totalCartValue.toString(),
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
                        Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_live_ILgsfZCZoFIKMb',
                    'amount': 100,
                    'name': 'Acme Corp.',
                    'description': 'Fine T-Shirt',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                  razorpay.open(options);
                      },
                     child: Text("CheckOut",
                     style: TextStyle(color: Colors.white),)
                     ),
                   ),
                ],
              ),
            )
          
              ),
              ],
            )),
      ),
    );
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}