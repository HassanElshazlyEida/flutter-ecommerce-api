import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:get/get.dart';

class ProductComponent extends StatefulWidget {
  final LayoutCubit cubit;
  final ProductModel model;

  const ProductComponent({super.key, required this.cubit, required this.model});

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var cubit = widget.cubit;
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
                    Column(
                      children: [
                        Text('${model.price!} ${'EGP'.tr}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),),
                        const SizedBox(width: 5,),
                        if(model.discount != 0)
                        Text('${model.oldPrice!} ${'EGP'.tr}',style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                      ],
                    ),
                  GestureDetector(
                    onTap: () {
                      // Add your onTap functionality here
                    },
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          model.isFavorite = !model.isFavorite!;
                        });
                        cubit.changeProductFavorite(model.id!);
                        Get.snackbar(
                          'Success'.tr,
                          (model.isFavorite == true) ? 'Added to favorites'.tr : 'Removed from favorites'.tr,
                   
                        );
                      },
                      icon: const Icon(Icons.favorite),
                      color: (model.isFavorite == true) ? Colors.pink : Colors.grey,
                    ),
                  )
                  
                ],
              )
              
            ],
          ),
        ));
  }
}