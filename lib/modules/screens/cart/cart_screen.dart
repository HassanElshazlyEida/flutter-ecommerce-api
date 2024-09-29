import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:get/get.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = Get.find<LayoutCubit>();
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          if(state is AddOrRemoveCartState || state is LoadingCartState){
            return const Center(child: CupertinoActivityIndicator());
          }
          return Scaffold(
            body:  Padding(
              padding: const EdgeInsets.all(8.0),
              child : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Total Price'.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('${cubit.totalPrice} ${'EGP'.tr}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue),),
                    if(cubit.subTotal != cubit.totalPrice)
                    Text('${cubit.subTotal} ${'EGP'.tr}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                  ],
                ),
                const SizedBox(height: 10,), 
                Expanded(
                  
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemCount:  cubit.cart.length,
                    itemBuilder: (context, index) {
                      return _productCartItem(cubit.cart[index]);
                    },
                  ),
                )
            
              ],
            ),
            )
          );
        }
    );
  }
   Widget _productCartItem(ProductModel model){
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
              cubit.products.where((element) => element.id == model.id).first.inCart = false;
              cubit.toggleProductCart(model.id!);
              Get.snackbar(
                'Success'.tr, 
                'Removed from cart'.tr,
              );
            },
          ),
   
      )
      );
  }
}