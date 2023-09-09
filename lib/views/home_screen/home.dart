
import 'package:e_mart_store/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../../controllers/home_controllers.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());

    var navbarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label:home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label:categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label:cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label:account),
    ];

    var navBody=[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      const ProfileScreen()
    ];

    return Scaffold(
      body: WillPopScope( //to show conformation popup widget before exit
        onWillPop: ()async{
          showDialog(
              barrierDismissible: false, //used to avoid exiting unnecessary ontap on screen
              context: context, builder: (context)=>exitDialog(context));
          return false;
        },
        child: Column(
          children: [
            Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value),)),
          ],
        ),
      ),
      bottomNavigationBar: Obx(()=>
         BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed, // used to show labels and bottom navigation bar to be fixed
          backgroundColor: whiteColor,
          items: navbarItem,
          onTap: (value){
            controller.currentNavIndex.value=value;
          },
        ),
      ),
    );
  }
}
