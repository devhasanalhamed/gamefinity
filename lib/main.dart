import 'package:flutter/material.dart';
import 'package:gamefinity/screens/no_connection.dart';

import 'global/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightScaffoldColor,
        primaryColor: lightCardColor,
        backgroundColor: lightBackgroundColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: lightIconsColor,
          ),
          backgroundColor: lightScaffoldColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: lightTextColor, fontSize: 22, fontWeight: FontWeight.bold),
          elevation: 0,
        ),
        iconTheme: IconThemeData(
          color: lightIconsColor,
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.blue,
          // selectionHandleColor: Colors.blue,
        ),
        // textTheme: TextTheme()
        // textTheme: Theme.of(context).textTheme.apply(
        //       bodyColor: Colors.black,
        //       displayColor: Colors.black,
        //     ),
        cardColor: lightCardColor,
        brightness: Brightness.light,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: lightIconsColor,
              brightness: Brightness.light,
            ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: lightIconsColor,
        ),
      ),
      home: const NoConnection(),
    );
  }
}
