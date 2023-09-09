// import 'package:emart_app/views/splash_screen/splash_screen.dart';
// import 'package:firebase_core/firebase_core.d
import 'package:e_mart_store/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';
import 'constants/styles.dart';
//import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //print(Colors.lightBlue.value);
    //if we are using getx then we  have to change material app to getmaterial app
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            //to set appbar icons color
              iconTheme: IconThemeData(
                  color: darkFontGrey
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent
          ),
          fontFamily: regular
      ),
      home: const SplashScreen(),
    );
  }
}