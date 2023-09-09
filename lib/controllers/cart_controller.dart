import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_store/controllers/home_controllers.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';

class CartController extends GetxController{
  var totalp=0.obs;

  //text controller for shipping variables
  var addressContrller=TextEditingController();
  var cityContrller=TextEditingController();
  var stateContrller=TextEditingController();
  var postalcodeContrller=TextEditingController();
  var phoneContrller=TextEditingController();

  var paymentIndex=0.obs;
  late dynamic productSnapshot;
  var products=[];

  var placingOrder =false.obs;
  
  calculate(data){
     totalp.value=0;
    for(var i=0;i<data.length;i++){
      totalp.value=totalp.value+int.parse(data[i]['tprice'].toString());
    }

  }

  changePaymentIndex(index){
    paymentIndex.value=index;
  }
  
  placeMyOrder({required orderPaymentMethod,required totalAmount})async{

    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_by':currentUser!.uid,
      'order_by_name':Get.find<HomeController>().username,
      'order_by_email':currentUser!.email,
      'order_by_address':addressContrller.text,
      'order_by_city':cityContrller.text,
      'order_by_state':stateContrller.text,
      'order_by_postalcode':postalcodeContrller.text,
      'order_by_phone':phoneContrller.text,
      'shipping_method':"Home Delivery",
      'payment_method':orderPaymentMethod,
      'order_placed':true,
      'order_confirmed':false,
      'order_delivered':false,
      "order_on_delivery":false,
      'total_amount':totalAmount,
      'orders':FieldValue.arrayUnion(products)

    });
    placingOrder(false);
  }
  
  
  getProductDetails(){

     for(var i=0;i<productSnapshot.length;i++){
       products.add({
         'color':productSnapshot[i]['color'],
         'img':productSnapshot[i]['img'],
         'vendor_id':productSnapshot[i]['vendor_id'],
         'tprice':productSnapshot[i]['tprice'],
         'qty':productSnapshot[i]['qty'],
         'title':productSnapshot[i]['title'],
       });
       
     }
  }

  clearCart(){
    for( var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }


}