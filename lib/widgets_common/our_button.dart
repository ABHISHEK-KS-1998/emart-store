
import '../constants/consts.dart';

Widget ourButton({String? title,onpress,color,textColor,}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.all(12)
    ),
      onPressed: onpress,
      child: title!.text.color(textColor).fontFamily(bold).make()
  );
}