
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_store/controllers/auth_controller.dart';
import 'package:e_mart_store/controllers/profile_controller.dart';
import 'package:e_mart_store/services/firestore_services.dart';
import 'package:e_mart_store/views/auth_screen/login_screen.dart';
import 'package:e_mart_store/views/profile_screen/components/edit_profile_screen.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../../constants/lists.dart';
import '../../widgets_common/bg_widget.dart';
import 'components/details_card_dart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot <QuerySnapshot>snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor)),
                  );
                }
                else {
                  var data = snapshot.data!.docs[0];
                  return SafeArea(
                    child: Column(
                      children: [
                        //edit profile button
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.edit, color: whiteColor))
                              .onTap(() {
                            controller.nameController.text = data['name'];
                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),

                        //user details section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == '' ? Image
                                  .asset(
                                imgProfile2,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make() :
                              Image
                                  .network(
                                data['imageUrl'],
                                width: 100,
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      "${data['name']}".text.white.fontFamily(
                                          semibold).make(),
                                      "${data['email']}".text.white.make()
                                    ],
                                  )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.white)),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: logout.text
                                      .fontFamily(semibold)
                                      .white
                                      .make())
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data['cart_count'],
                                title: "in your cart",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['wishlist_count'],
                                title: "in your wishlist",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['order_count'],
                                title: "in your your orders",
                                width: context.screenWidth / 3.4),
                          ],
                        ),
                        //button setion
                        ListView
                            .separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black38,
                              );
                            },
                            itemCount: profileButtonList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.asset(
                                  profileButtonsIcons[index],
                                  width: 22,
                                ),
                                title: profileButtonList[index]
                                    .text
                                    .fontFamily(bold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            })
                            .box
                            .rounded
                            .margin(EdgeInsets.all(12))
                            .padding(EdgeInsets.symmetric(horizontal: 16))
                            .white
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make()
                      ],
                    ),
                  );
                }
              },
            )
        ));
  }
}
