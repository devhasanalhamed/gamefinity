import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/global/theme.dart';

class DeveloperWidget extends StatelessWidget {
  const DeveloperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        imageUrl: '',
        errorWidget: const Icon(
          Icons.dangerous,
          size: 28.0,
        ),
        boxFit: BoxFit.fill,
      ),
      title: Text('user name'),
      subtitle: Text('example@email.com '),
      trailing: Text(
        'user role',
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
