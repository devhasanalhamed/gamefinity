import 'package:flutter/material.dart';
import 'package:gamefinity/core/global/theme.dart';
import 'package:gamefinity/core/helpers/size_config.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/controllers/settings_provider.dart';
import 'package:gamefinity/mvc/views/screens/category_screen.dart';
import 'package:gamefinity/mvc/views/screens/developers_screen.dart';
import 'package:gamefinity/mvc/views/widgets/homepage.dart';
import 'package:gamefinity/mvc/views/widgets/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final currentPage = <Widget>[
    const Homepage(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const CategoryScreen(),
                    type: PageTransitionType.fade,
                  ));
            },
            icon: const Icon(
              Icons.category,
            ),
          ),
          actions: [
            IconButton.outlined(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                      child: const DevelopersScreen(),
                      type: PageTransitionType.fade,
                    ));
              },
              icon: const Icon(Icons.import_contacts),
            ),
            IconButton.outlined(
              onPressed: () {
                final x =
                    Provider.of<SettingsProvider>(context, listen: false).local;
                Provider.of<SettingsProvider>(context, listen: false)
                    .updateLocal(x == 'ar' ? 'en' : 'ar');
              },
              icon: const Icon(Icons.language),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: currentPage[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: S.of(context).profile,
            ),
          ],
        ),
      ),
    );
  }
}
