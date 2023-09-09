import 'package:e_mart_store/controllers/product_controller.dart';
import 'package:e_mart_store/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../../constants/lists.dart';
import '../../widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final dynamic data;
  final String? title;

  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(Icons.favorite_outlined),
                color: controller.isFav.value ? redColor : darkFontGrey,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //swier section
                          VxSwiper.builder(
                              autoPlay: true,
                              height: 500,
                              itemCount: data['p_imgs'].length,
                              viewportFraction: 1.0,
                              //used to display   fullscreen of one image
                              aspectRatio: 16 / 9,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  data['p_imgs'][index],
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                );
                              }),
                          10.heightBox,
                          //title and details section
                          title!.text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          //rating
                          VxRating(
                            isSelectable: false,
                            value: double.parse(data['p_rating']),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            count: 5,
                            maxRating: 5,
                            size: 25,
                          ),
                          10.heightBox,
                          "${data['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Seller"
                                        .text
                                        .white
                                        .fontFamily(semibold)
                                        .make(),
                                    5.heightBox,
                                    "${data['p_seller']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make()
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: darkFontGrey,
                                ).onTap(() {
                                  Get.to(() => ChatScreen(), arguments: [
                                    data['p_seller'],
                                    data['vendor_id']
                                  ]);
                                }),
                              )
                            ],
                          )
                              .box
                              .height(60)
                              .padding(EdgeInsets.symmetric(horizontal: 16))
                              .color(textfieldGrey)
                              .make(),
                          //color
                          10.heightBox,
                          Obx(
                            () => Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Color: "
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                    ),
                                    Row(
                                      children: List.generate(
                                          data['p_colors'].length,
                                          (index) => Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  VxBox()
                                                      .size(40, 40)
                                                      .color(Color(
                                                              data['p_colors']
                                                                  [index])
                                                          .withOpacity(1.0))
                                                      .margin(
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4))
                                                      .roundedFull
                                                      .make()
                                                      .onTap(() {
                                                    //feature not working check the code
                                                    controller.changeColorIndex(
                                                        index);
                                                  }),
                                                  Visibility(
                                                      visible: index ==
                                                          controller
                                                              .colorIndex.value,
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              )),
                                    )
                                  ],
                                ).box.padding(EdgeInsets.all(8)).make(),
                                //quantity row
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Quantity: "
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                    ),
                                    Obx(
                                      () => Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.decreaseQuantiy();
                                                controller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: Icon(Icons.remove)),
                                          controller.quantity.value.text
                                              .size(16)
                                              .color(darkFontGrey)
                                              .fontFamily(bold)
                                              .make(),
                                          IconButton(
                                              onPressed: () {
                                                controller.increaseQuantiy(
                                                    int.parse(
                                                        data['p_quantity']));
                                                controller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: Icon(Icons.add)),
                                          10.widthBox,
                                          "${data['p_quantity']} available"
                                              .text
                                              .color(textfieldGrey)
                                              .make()
                                        ],
                                      ),
                                    )
                                  ],
                                ).box.padding(EdgeInsets.all(8)).make(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Total Price : "
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                    ),
                                    "${controller.totalPrice.value}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make()
                                  ],
                                )
                                    .box
                                    .padding(EdgeInsets.all(8))
                                    .color(lightgolden)
                                    .make(),
                              ],
                            ).box.white.shadowSm.make(),
                          ),
                          //description section
                          10.heightBox,
                          "Description"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          "${data['p_desc']}".text.color(darkFontGrey).make(),
                          10.heightBox,
                          //buttons sec
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            //without using the shrinkwrap as true  listview is not going to slide
                            children: List.generate(
                                itemDetailsButtonList.length,
                                (index) => ListTile(
                                      title: itemDetailsButtonList[index]
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      trailing: Icon(Icons.arrow_forward),
                                    )),
                          ),
                          20.heightBox,
                          //products you may like section
                          productsYouMayLike.text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          10.heightBox,
                          //copied this widget from homscreen.dart featured products
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            imgP1,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "Laptop 4GB/64GB"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "\$600"
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .roundedSM
                                          .white
                                          .padding(EdgeInsets.all(8))
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .make()),
                            ),
                          )
                          //here our details UI is also completed
                        ],
                      ),
                    ))),
            SizedBox(
              width: double.infinity,
              child: ourButton(
                  color: redColor,
                  onpress: () {
                    controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        vendorID: data['vendor_id'],
                        img: data['p_imgs'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                        price: data['p_price']);
                    VxToast.show(context, msg: 'Added to Cart');
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
