import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerComponent extends StatelessWidget {
  final LayoutCubit cubit;

  const BannerComponent({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Column(
      children: [
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
                  
      ],
    );
  }
}