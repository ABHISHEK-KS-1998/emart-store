import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_store/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var subcat = [];
  var totalPrice = 0.obs;
  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  increaseQuantiy(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    } else {
      Get.snackbar(
        "item count",
        "No more items available ",
        backgroundColor: Colors.cyan,
        colorText: Colors.white,
      );
    }
  }

  decreaseQuantiy() {
    if (quantity.value > 0) {
      quantity.value--;
    } else {
      Get.snackbar(
        "item count",
        "you should atleast add an item in the cart!",
        backgroundColor: Colors.cyan,
        colorText: Colors.white,
      );
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, price, sellername, color, qty, tprice, context,vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'price': price,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'vendor_id':vendorID,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  //to reset quantity
  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  //adding products to wishlist
  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added  to Wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  //set wishlisticon color
  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
