import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CustomNotifications {
  initInfo() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          playSound: true,
          channelKey: 'Pay Mobile',
          channelName: 'Pay Mobile',
          channelDescription: 'Notification channel for Pay Mobile',
          //defaultColor: primaryAppColor,
          //ledColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          icon: 'resource://drawable/notifications_logo.png',
        )
      ],
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('..................onMessage...................');
      print(
          'onMessage: ${message.notification?.title}/${message.notification?.body}');

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'Pay Mobile',
          title: message.notification?.title,
          body: message.notification?.body,
          largeIcon: "asset://assets/images/notifications_logo.png",
        ),
      );
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print("User declined or has accepted permission");
    }
  }
}
