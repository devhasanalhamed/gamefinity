import 'package:firebase_auth/firebase_auth.dart';
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
        top: SizeConfig.safeBlockVertical! * 1,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: SizeConfig.safeBlockHorizontal! * 12,
                    ),
                    ElevatedButton.icon(
                      onPressed: FirebaseAuth.instance.signOut,
                      icon: const Icon(Icons.logout),
                      label: Text(
                        S.of(context).signOut,
                      ),
                    )
                  ],
                ),
                SizedBox(height: SizeConfig.safeBlockVertical! * 1),
                const Expanded(
                  child: ProfilePageView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
