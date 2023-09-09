
import 'package:e_mart_store/controllers/product_controller.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../../constants/lists.dart';
import '../../widgets_common/bg_widget.dart';
import 'category_detials.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200
              ),
              itemBuilder: (context,index){
               return Column(
                 children: [
                   Image.asset(categoryImages[index],height: 130,width: 200,fit: BoxFit.cover,),
                   10.heightBox,
                   "${categoriesList[index]}".text.color(darkFontGrey).align(TextAlign.center).make()
                 ],
               ).box.white.clip(Clip.antiAlias).shadowSm.rounded.make().onTap(() {

                 controller.getSubCategories(categoriesList[index]);
                 Get.to(()=>CategoryDetails(title: categoriesList[index]));
               });
              }),
        ),
      )
    );
  }
}
