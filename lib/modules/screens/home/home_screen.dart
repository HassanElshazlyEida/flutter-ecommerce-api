import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    final pageController = PageController();
    final TextEditingController searchController = TextEditingController();

    return BlocBuilder<LayoutCubit, LayoutStates>(
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
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.banners.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(10), // Set the border radius
                              child: Image.network(
                                '${cubit.banners[index].image}',
                                fit: BoxFit.fill,
                              ),
                            ),
                        );
                        
                      },
                    ),
                  )
                  ,
                  const SizedBox(height: 15,),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: cubit.banners.length,
                      effect: const ScrollingDotsEffect(
                        dotColor: secondColor,
                        activeDotColor: mainColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0,
                        
                      ),
                                    
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Categories',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      TextButton(onPressed: (){
                        cubit.changeBottomNavIndex(cubit.screenRoutes[Routes.categories]!);
                        Get.toNamed(Routes.home);
                      }, child: const Text('View All',style: TextStyle(color: mainColor),))
                    ],
                  ),
                  cubit.categories.isEmpty
                  ? const Center(child: CupertinoActivityIndicator(),)
                  :
                   SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.categories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 10,),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: 
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('${cubit.categories[index].image}'),
                            ),
                        );
                      },
                    )
                  ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Products',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    TextButton(onPressed: (){
                      cubit.changeBottomNavIndex(cubit.screenRoutes[Routes.categories]!);
                      Get.toNamed(Routes.home);
                    }, child: const Text('View All',style: TextStyle(color: mainColor),))
                  ],
                  ),
                  const SizedBox(height: 10,),
                    TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      cubit.filterProducts(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
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
                  cubit.products.isEmpty
                  ? const Center(child: CupertinoActivityIndicator(),)
                  :
                  GridView.builder(
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
                        return _productItem(cubit.filteredProducts.isEmpty? cubit.products[index] : cubit.filteredProducts[index]);
                      },
                    ),
                
                ],
              ),
            ));
      },
    );
  }
  Widget _productItem(ProductModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                offset: Offset(0, 1),
              )
            ]
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: Image.network(model.image!,fit: BoxFit.fill),
              ),
              const SizedBox(height: 20,),
              Text(model.name!,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
              Text(model.description!,maxLines: 2, style: const TextStyle(fontSize: 13,color: Colors.grey,overflow: TextOverflow.ellipsis),),
              const SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text('${model.price!}\$',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),),
                        const SizedBox(width: 5,),
                        if(model.discount != 0)
                        Text('${model.oldPrice!}\$',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child:  const Icon(Icons.favorite_border,color: Colors.pink,size: 20,),
                    
                    onTap: (){},
                  )
                  
                ],
              )
              
            ],
          ),
        ));
  }
}
