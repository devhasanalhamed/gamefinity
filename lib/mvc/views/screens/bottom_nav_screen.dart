import 'package:flutter/material.dart';
import 'package:gamefinity/core/helpers/size_config.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/views/screens/bottom_nav_widgets/appBars/home_app_bar.dart';
import 'package:gamefinity/mvc/views/screens/bottom_nav_widgets/appBars/profile_app_bar.dart';
import 'package:gamefinity/mvc/views/screens/bottom_nav_widgets/screens/explore.dart';
import 'package:gamefinity/mvc/views/screens/bottom_nav_widgets/screens/homepage.dart';
import 'package:gamefinity/mvc/views/screens/bottom_nav_widgets/screens/profile_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  final _pages = <Widget>[
    const Homepage(),
    const Explore(),
    const Profile(),
  ];

  final appBars = <PreferredSizeWidget?>[
    const HomeAppBar(),
    null,
    const ProfileAppBar(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationItems = [
      BottomNavigationBarItem(
        icon: const Icon(LucideIcons.home),
        label: S.of(context).home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(LucideIcons.search),
        label: S.of(context).explore,
      ),
      BottomNavigationBarItem(
        icon: const Icon(LucideIcons.user2),
        label: S.of(context).profile,
      ),
    ];

    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: appBars.elementAtOrNull(currentIndex),
        body: SafeArea(
          child: _pages.elementAt(currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: bottomNavigationItems,
        ),
      ),
    );
  }
}
