import 'package:e_mart_store/constants/consts.dart';
import 'package:e_mart_store/controllers/cart_controller.dart';
import 'package:e_mart_store/views/cart_screen/payment_method.dart';
import 'package:e_mart_store/widgets_common/custom_textfeild.dart';
import 'package:e_mart_store/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          title: "Continue",
          textColor: whiteColor,
          onpress: () {
            if(controller.addressContrller.text.length>10 ){
              Get.to(()=>PaymentMethods());
            }else
            {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextFeild(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressContrller),
            customTextFeild(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityContrller),
            customTextFeild(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateContrller),
            customTextFeild(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeContrller),
            customTextFeild(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneContrller)
          ],
        ),
      ),
    );
  }
}
