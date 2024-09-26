import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/component/banner_component.dart';
import 'package:flutter_ecommerce/component/categories_row_component.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';
import 'package:flutter_ecommerce/component/product_component.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';
import 'package:get/get.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = Get.find<LayoutCubit>();
    final TextEditingController searchController = TextEditingController();

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        return Scaffold(
            drawer: const MenuDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                
                  cubit.banners.isEmpty
                  ? const Center(child: CupertinoActivityIndicator(),)
                  :
                  BannerComponent(cubit: cubit),
                  
                  cubit.categories.isEmpty
                  ? const Center(child: CupertinoActivityIndicator(),)
                  :
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Categories'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          TextButton(onPressed: (){
                            cubit.changeBottomNavIndex(cubit.screenRoutes[Routes.categories]!);
                            Get.toNamed(Routes.home);
                          }, child:  Text('View All'.tr,style: const TextStyle(color: mainColor),))
                        ],
                      ),
                      CategoriesRowComponent(cubit:cubit),
                    ],
                  ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Products'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    TextButton(onPressed: (){
                      cubit.changeBottomNavIndex(cubit.screenRoutes[Routes.categories]!);
                      Get.toNamed(Routes.home);
                    }, child:  Text('View All'.tr,style: const TextStyle(color: mainColor),))
                  ],
                  ),
                  const SizedBox(height: 10,),
                    TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      cubit.filterProducts(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search'.tr,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          cubit.filterProducts('');
                        },
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  (cubit.products.isNotEmpty)?GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        
                      ),
                      itemCount: cubit.filteredProducts.isEmpty? cubit.products.length : cubit.filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductComponent(
                          model:cubit.filteredProducts.isEmpty? cubit.products[index] : cubit.filteredProducts[index],
                          cubit: cubit,
                        );
                      },
                    ):
                    const Center(child: CupertinoActivityIndicator(),)
                
                ],
              ),
            ));
      },
    );
  }


}
