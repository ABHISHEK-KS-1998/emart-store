import '../../../constants/consts.dart';

Widget featuredButton({image,String? title,}){
  return Row(
    children: [
      Image.asset(image,width: 40,),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).white.roundedSM.outerShadowSm.padding(EdgeInsets.all(4)).make();
}