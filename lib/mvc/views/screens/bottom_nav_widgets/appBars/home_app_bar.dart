import 'package:flutter/material.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/controllers/settings_provider.dart';
import 'package:gamefinity/mvc/views/screens/category_screen.dart';
import 'package:gamefinity/mvc/views/screens/developers_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // Define the desired height of your custom AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          LucideIcons.shapes,
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
          icon: const Icon(LucideIcons.binary),
        ),
        IconButton.outlined(
          onPressed: () {
            final x =
                Provider.of<SettingsProvider>(context, listen: false).local;
            Provider.of<SettingsProvider>(context, listen: false)
                .updateLocal(x == 'ar' ? 'en' : 'ar');
          },
          icon: const Icon(LucideIcons.languages),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(S.of(context).title),
    );
  }
}
