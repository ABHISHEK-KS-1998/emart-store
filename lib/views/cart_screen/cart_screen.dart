import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_store/controllers/cart_controller.dart';
import 'package:e_mart_store/services/firestore_services.dart';
import 'package:e_mart_store/views/cart_screen/shipping_screen.dart';
import 'package:e_mart_store/widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(CartController());

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height:60,
        child: ourButton(
          color: redColor,
          onpress: (){
           Get.to(()=>ShippingScreen());
          },
          title: "Proceed to Shipping",
          textColor: whiteColor
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),) ,
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          }else{
            var data=snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (BuildContext context,int index){
                          return ListTile(
                            leading:Image.network('${data[index]['img']}',width: 80,fit: BoxFit.cover,), // here width is used to allign the products
                            title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                            subtitle: "${data[index]['tprice']}".text.color(redColor).fontFamily(semibold).make(),
                            trailing: Icon(Icons.delete,color: redColor,).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          );
                          }
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price:".text.color(darkFontGrey).fontFamily(semibold).make(),
                      5.widthBox,
                      Obx(()=> "${controller.totalp.value}".numCurrency.text.color(redColor).fontFamily(semibold).make()),
                    ],
                  ).box.width(context.screenWidth-60).padding(EdgeInsets.all(12)).color(lightgolden).roundedSM.make(),
                  10.heightBox,
                  // SizedBox(
                  //     width: context.screenWidth-60,
                  //     child: ourButton(
                  //       color: redColor,
                  //       onpress: (){},
                  //       textColor: whiteColor,
                  //       title: "Proceed to shipping",
                  //     ))

                ],
              ),
            );
          }
        },
      )
    );
  }
}
