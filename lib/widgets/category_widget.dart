import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
const CategoryWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        FancyShimmerImage(
          
          imageUrl: '',
        )
      ],
    );
  }
}