import 'package:e_mart_store/constants/consts.dart';
import 'package:e_mart_store/constants/lists.dart';
import 'package:e_mart_store/controllers/cart_controller.dart';
import 'package:get/get.dart';

import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(()=> Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose payment method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          ):ourButton(
            color: redColor,
            title: "Place My Order",
            textColor: whiteColor,
            onpress: () async{
              controller.placeMyOrder(
                  orderPaymentMethod:
                      paymentsMethods[controller.paymentIndex.value],
              totalAmount: controller.totalp.value);
              await controller.clearCart();
              VxToast.show(context, msg: "Order Placed Successfully");
              Get.offAll(Home());
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsimgs.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      //forcing the image to circular border radius
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4,
                          )),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodsimgs[index],
                            width: double.infinity,
                            height: 120,
                            colorBlendMode: controller.paymentIndex.value == index
                                ? BlendMode.darken
                                : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.4)
                                : Colors.transparent,
                            fit: BoxFit.cover,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      value: true,
                                      onChanged: (value) {}),
                                )
                              : Container(),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: paymentsMethods[index]
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make())
                        ],
                      )),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
