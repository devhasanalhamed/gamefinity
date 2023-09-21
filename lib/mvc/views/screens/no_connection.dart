import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/views/screens/bottom_nav_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  _NoConnectionState createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  bool _isConnected = true;
  get isConnected => _isConnected;

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  Future checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    setState(() {
      print('trig');
      if (result == true) {
        _isConnected = true;
      } else {
        _isConnected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? const BottomNavScreen()
        : Center(
            child: SvgPicture.asset(
              'assets/images/no_connection.svg',
              semanticsLabel: 'No Connection',
            ),
          );
  }
}
