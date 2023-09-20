import 'package:flutter/material.dart';
import 'package:gamefinity/core/helpers/size_config.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/views/widgets/profile_pageview.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical! * 2,
      ),
      child: Stack(
        children: [
          // CustomPaint(
          //   painter: CustomPainter(
          //     repaint:
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: SizeConfig.safeBlockHorizontal! * 12,
              ),
              SizedBox(height: SizeConfig.safeBlockVertical! * 1),
              const Text(
                '@devhassanmohammed',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Expanded(
                child: ProfilePageView(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
