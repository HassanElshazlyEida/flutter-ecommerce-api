import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
      final TextEditingController searchController = TextEditingController();

    return  Scaffold(
      body: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          if(state is LoadingWishlistState || state is AddOrRemoveWishlistState){
            return const Center(child: CupertinoActivityIndicator());
          }
          return Scaffold(
            body:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                      const SizedBox(height: 10,),
                      TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        cubit.filterWishlist(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search'.tr,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon:IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            cubit.filterWishlist('');
                          },
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    cubit.wishlist.isEmpty
                    ? 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No products found'.tr)
                      ],
                    )
                    :
                    Expanded(
                      child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      itemCount:  cubit.filteredWishlist.isEmpty? cubit.wishlist.length : cubit.filteredWishlist.length,
                      itemBuilder: (context, index) {
                        return _productWishlistItem(cubit.filteredWishlist.isEmpty? cubit.wishlist[index] : cubit.filteredWishlist[index]);
                      },
                    )
                    )

              
                  ],
                ),
              )
             
          );
        },
      )
    );
  }

  Widget _productWishlistItem(ProductModel model){
    final cubit = Get.find<LayoutCubit>();
    return Card(
      color: Colors.white,
      surfaceTintColor:Colors.white,
      child:
         ListTile(
          
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Set the border radius
            child: Image.network(
              model.image!,
              width: 70,
 
              fit: BoxFit.fill,
            ),
          ),
          title: Text(model.name!,maxLines: 2,style: const TextStyle(fontSize: 14),),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.price!} ${'EGP'.tr}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue),),
              const SizedBox(width: 5,),
              if(model.discount != 0)
              Text('${model.oldPrice!} ${'EGP'.tr}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey,decoration: TextDecoration.lineThrough),),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

              cubit.products.where((element) => element.id == model.id).first.isFavorite = false;
              cubit.toggleProductWishlist(model.id!);
              Get.snackbar(
                'Success'.tr, 
                'Removed from favorites'.tr,
              );
            },
          ),
   
      )
      );
  }
}