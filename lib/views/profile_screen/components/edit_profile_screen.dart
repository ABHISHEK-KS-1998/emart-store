import 'dart:io';

import 'package:e_mart_store/constants/consts.dart';
import 'package:e_mart_store/controllers/profile_controller.dart';
import 'package:e_mart_store/widgets_common/bg_widget.dart';
import 'package:e_mart_store/widgets_common/custom_textfeild.dart';
import 'package:e_mart_store/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();


    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(()=>
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
                children: [
                  //if data image url and controller path is empty
                  data['imageUrl']=='' && controller.profileImgPath.isEmpty?Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,)
                      .box.roundedFull.clip(Clip.antiAlias).make():
                      //if data is not empty but controller path is empty
                  data['imageUrl']!='' && controller.profileImgPath.isEmpty?
                      Image.network(data['imageUrl'],width: 100,fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedFull.make():
                      //if both are empty
                  Image.file(
                    File(controller.profileImgPath.value),width: 100,fit: BoxFit.cover,)
                      .box.clip(Clip.antiAlias).roundedFull.make(),
                  10.heightBox,
                  ourButton(color: redColor,onpress: (){
                    controller.changeImage(context);
                  },textColor: whiteColor,title: 'Change'),
                  20.heightBox,
                  customTextFeild(controller: controller.nameController,hint: nameHint, title: name, isPass: false),
                  10.heightBox,
                  customTextFeild(controller: controller.oldpassController,hint: passwordHint, title: oldpass, isPass: true),
                  10.heightBox,
                  customTextFeild(controller: controller.newpassController,hint: passwordHint, title: newpass, isPass: true),
                  20.heightBox,

                  controller.isLoading.value? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor)):
                    SizedBox(
                    child: ourButton(color: redColor,onpress:()async{


                      controller.isLoading(true);
                      //if image is selected image
                      if(controller.profileImgPath.value.isNotEmpty){
                        await controller.uploadProfileImage();
                      }else{
                        controller.profileImageLink=data['imageUrl'];
                      }
                      //if old passwordmatches database
                      if(data['password'] == controller.oldpassController.text){

                        await controller.changeAuthPassword(
                          email: data['email'],
                          password: controller.oldpassController.text,
                          newpassword: controller.newpassController.text
                        );

                        await controller.updateProfile(
                            imgUrl:controller.profileImageLink,
                            name:controller.nameController.text,
                            password:controller.newpassController.text,);
                        VxToast.show(context, msg: "Updated");
                      }else{
                        VxToast.show(context, msg: "Wrong old Passwrd");
                        controller.isLoading(false);
                      }

                    },title: save,textColor: whiteColor,).box.width(context.screenWidth-60).make(),
                  )
                ],
              ).box.white.rounded.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50,left: 10,right: 10)).make(),
          ),
        ),
      )
    );
  }
}
