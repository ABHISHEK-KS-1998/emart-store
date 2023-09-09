import 'package:e_mart_store/controllers/auth_controller.dart';
import 'package:e_mart_store/views/home_screen/home.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfeild.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck =false;
  var controller=Get.put(AuthController());


  //text controllers
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordRetypeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false, //to avoid overflow
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            20.heightBox,
            Column(
              children: [
                customTextFeild(
                  controller: nameController,
                  title: name,
                  hint: nameHint,
                  isPass: false,
                ),
                customTextFeild(
                  controller: emailController,
                  title: email,
                  hint: emailHint,
                  isPass: false
                ),
                customTextFeild(controller: passwordController,title: password, hint: passwordHint,isPass: true),
                customTextFeild(controller: passwordRetypeController,title: retypepass, hint: passwordHint,isPass: true),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                      activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck=newValue;
                          });

                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style:
                                TextStyle(fontFamily: regular, color: fontGrey)),
                        TextSpan(
                            text: termAndCond,
                            style:
                                TextStyle(fontFamily: regular, color: redColor)),
                        TextSpan(
                            text: " & ",
                            style:
                                TextStyle(fontFamily:regular, color: fontGrey)),
                        TextSpan(
                            text: privacyPolicy,
                            style:
                                TextStyle(fontFamily: regular, color: redColor)),
                      ])),
                    )
                  ],
                ),
                ourButton(
                        color: isCheck == true? redColor:lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onpress: ()async {
                          if(isCheck!=false){
                            try{
                              await controller.signupMethod(context: context,
                                  email: emailController.text,
                                  password: passwordController.text).then((value){
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text
                                );
                              }).then((value){
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=>Home());
                              });
                            }catch (e){
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                            }
                          }
                        })
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                //wrapping into gesture detector of velocity x
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAccount.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    })
                  ],
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make()
          ],
        ),
      ),
    ));
  }
}
