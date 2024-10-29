//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereats/utils/colors.dart';
import 'package:ubereats/utils/textStyles.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categories = [
    ['assets/images/categories/indian.png', 'Indian'],
    ['assets/images/categories/Banana.png', 'Healthy'],
    ['assets/images/categories/alcohol.png', 'Alcohol'],
    ['assets/images/categories/american.png', 'American'],
    ['assets/images/categories/asian.png', 'Asian'],
    ['assets/images/categories/burger.png', 'Burger'],
    ['assets/images/categories/carrebian.png', 'Carrebian'],
    ['assets/images/categories/chinese.png', 'Chinese'],
    ['assets/images/categories/convenience.png', 'Convenience'],
    ['assets/images/categories/dessert.png', 'Dessert'],
    ['assets/images/categories/fastFood.png', 'FastFood'],
    ['assets/images/categories/flower.png', 'Flower'],
    ['assets/images/categories/french.png', 'French'],
    ['assets/images/categories/grocery.png', 'Grocery'],
    ['assets/images/categories/icecream.png', 'Icecream'],
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            'All Categories',
            style: AppTextStyles.body16,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 3.h,
          ),
          GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.sp,
                            ),
                            color: greyShade3),
                        child: Image(
                          image: AssetImage(
                            categories[index][0],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      categories[index][1],
                      style: AppTextStyles.small10Bold,
                    )
                  ],
                );
              })
        ],
      )),
    );
  }
}
