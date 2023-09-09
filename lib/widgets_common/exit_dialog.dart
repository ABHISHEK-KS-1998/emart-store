import 'package:e_mart_store/views/home_screen/home.dart';
import 'package:e_mart_store/widgets_common/our_button.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/consts.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              title: 'Yes',color: redColor,onpress: (){
                SystemNavigator.pop();
            },textColor: whiteColor
            ),

            ourButton(
                title: 'No',color: redColor,onpress: (){
                  Navigator.pop(context);
            },textColor: whiteColor
            )
          ],
        )
      ],
    ).box.color(lightGrey).roundedSM.padding(EdgeInsets.all(12)).make(),
  );
}