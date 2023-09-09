
import '../constants/consts.dart';

Widget applogoWidget() {
  //using velocity x
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}
