import 'package:flutter/material.dart';
import 'package:gamefinity/core/helpers/size_config.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  ProfilePageViewState createState() => ProfilePageViewState();
}

class ProfilePageViewState extends State<ProfilePageView> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: currentPage == 0 ? Colors.grey[200] : null,
                ),
                child: IconButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    size: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: currentPage == 1 ? Colors.grey[200] : null,
                ),
                child: IconButton(
                  onPressed: () {
                    pageController.jumpToPage(1);
                  },
                  icon: const Icon(
                    Icons.grid_4x4,
                    size: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: currentPage == 2 ? Colors.grey[200] : null,
                ),
                child: IconButton(
                  onPressed: () {
                    pageController.jumpToPage(2);
                  },
                  icon: const Icon(
                    Icons.message,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[300],
          endIndent: null,
          height: 0,
          thickness: 2,
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              currentPage = value;
            }),
            children: const [
              Center(
                child: Text('الإعجابات'),
              ),
              Center(
                child: Text('المشاركات'),
              ),
              Center(
                child: Text('الرسائل الخاصة'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
