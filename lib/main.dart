import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gamefinity/core/helpers/firebase_api.dart';
import 'package:gamefinity/core/services/shared_preferences.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/controllers/auth_provider.dart';
import 'package:gamefinity/mvc/controllers/settings_provider.dart';
import 'package:gamefinity/mvc/views/screens/no_connection.dart';
import 'package:provider/provider.dart';

import 'core/global/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAPI().initNotifications();
  await SharedPref.initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          locale: Locale(
            Provider.of<SettingsProvider>(context).local ??
                SharedPref.lang ??
                'en',
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Gamefinity',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Tajawal',
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
                color: lightTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
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
        ),
      ),
    );
  }
}
