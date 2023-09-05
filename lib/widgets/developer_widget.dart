import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/global/theme.dart';
import 'package:gamefinity/models/users_model.dart';
import 'package:provider/provider.dart';

class DeveloperWidget extends StatelessWidget {
  const DeveloperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        imageUrl: user.avatar!,
        errorWidget: const Icon(
          Icons.dangerous,
          size: 28.0,
        ),
        boxFit: BoxFit.fill,
      ),
      title: Text(user.name!),
      subtitle: Text(user.email!),
      trailing: Text(
        user.role!,
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
