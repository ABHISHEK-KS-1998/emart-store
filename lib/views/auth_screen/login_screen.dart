
import 'package:e_mart_store/controllers/auth_controller.dart';
import 'package:e_mart_store/views/auth_screen/signup_screen.dart';
import 'package:e_mart_store/views/home_screen/home_screen.dart';

import '../../constants/consts.dart';
import '../../constants/lists.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfeild.dart';
import '../../widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false, //to avoid overflow
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
                20.heightBox,
                Obx(()=> Column(
                  children: [
                    customTextFeild(
                        title: 'Email',
                        hint: emailHint,
                        isPass: false,
                        controller: controller.emailController),
                    customTextFeild(
                        title: 'Password',
                        hint: passwordHint,
                        isPass: true,
                        controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetpass.text.make()),
                    ),
                    5.heightBox,
                    controller.isLoading.value ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):ourButton(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onpress: () async{
                          controller.isLoading(true);
                          await controller.loginMethod(context: context).then((value){
                            if(value != null){
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(()=>const Home());
                            } //if something went wrong please check this code again
                            else {
                              controller.isLoading(false);
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                        color: lightgolden,
                        title: signup,
                        textColor: whiteColor,
                        onpress: () {
                          Get.to(() => const SignupScreen());
                        }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    loginwith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                              (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
                )
              ],
            ),
          ),
        ));
  }
}