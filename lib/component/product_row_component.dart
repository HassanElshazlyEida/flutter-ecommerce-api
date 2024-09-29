import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:get/get.dart';

class ProductRowComponent extends StatelessWidget {

  final ProductModel model;
  final Function() onPressed;
  const ProductRowComponent({super.key,required this.model,required this.onPressed});

  @override
  Widget build(BuildContext context) {

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
            onPressed: onPressed,
          ),
   
      )
      );
  }
}