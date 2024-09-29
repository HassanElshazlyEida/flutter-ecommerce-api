import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/component/product_row_component.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
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
            body:  
            cubit.totalPrice == 0 ?
            Center(child: Text('Cart is Empty'.tr,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)):
            Padding(
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
                        var model = cubit.cart[index];
                        return ProductRowComponent(
                          model : model,
                          onPressed: (){
                            cubit.products.where((element) => element.id == model.id).first.inCart = false;
                            cubit.toggleProductCart(model.id!);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Get.snackbar(
                                'Success'.tr, 
                                'Removed from cart'.tr,
                              );
                            });

                          },
                        );
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

}