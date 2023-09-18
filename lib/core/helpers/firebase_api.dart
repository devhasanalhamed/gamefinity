import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('handleBackgroundMessage function has been triggered');
  log('${message.notification?.title}');
  log('${message.notification?.body}');
  log('${message.data}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isFlutterLocalNotificationsInitialized = false;

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleMessage(RemoteMessage? message) async {
    log('handleMessage function has been triggered');
    if (message == null) return;
    log('${message.notification?.title}');
    log('${message.notification?.body}');
    log('${message.data}');
  }

  void initLocalNotification() async {
    log('initLocalNotification function has been triggered');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_stat_ff'),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        log('fev ${notificationResponse.payload}');
      },
    );
  }

  Future<void> setupFlutterNotifications() async {
    log('setupFlutterNotifications function has been triggered');

    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  initPushNotifications() {
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) {
    log('showFlutterNotification function has been triggered');

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@drawable/ic_stat_ff',
            // Specify the color
            // color: Colors.amber,
          ),
        ),
      );
    }
  }

  initNotifications() async {
    log('initNotifications function has been triggered');
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log('token: $fCMToken');
    await setupFlutterNotifications();
    initLocalNotification();
    initPushNotifications();
  }
}
