import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    final pageController = PageController();

    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return Scaffold(
            drawer: const MenuDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.clear),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      contentPadding: const EdgeInsets.all(0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                          child:Image.network('${cubit.banners[index].image}',fit: BoxFit.fill)
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
                      effect: const ExpandingDotsEffect(
                        dotColor: secondColor,
                        activeDotColor: mainColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                                    
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
