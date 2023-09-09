import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection: data['uid']==currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        //to make box color differ from seller to customer we use this condition
          color: data['uid']==currentUser!.uid ? redColor : darkFontGrey,

          //to not apply radius on bottomleftside of seller we use this condition
          borderRadius: data['uid']==currentUser!.uid ? BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)
          ):BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make()
        ],
      ),
    ),
  );
}
