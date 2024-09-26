import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';

class CategoriesRowComponent extends StatelessWidget {
  final LayoutCubit cubit;

  const CategoriesRowComponent({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cubit.categories.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('${cubit.categories[index].image}'),
              ),
            );
          },
        ));
  }
}
