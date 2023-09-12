import 'package:flutter/material.dart';
import 'package:gamefinity/helpers/size_config.dart';
import 'package:gamefinity/main.dart';
import 'package:gamefinity/screens/category_screen.dart';
import 'package:gamefinity/screens/developers_screen.dart';
import 'package:gamefinity/widgets/home.dart';
import 'package:gamefinity/widgets/profile.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final currentPage = <Widget>[
    const Home(),
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
              onPressed: () => setState(() {
                getLanguage();
              }),
              icon: const Icon(Icons.gamepad_outlined),
            ),
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
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: currentPage[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
