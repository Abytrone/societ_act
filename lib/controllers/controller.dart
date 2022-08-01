import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societ_act/main.dart';

class Controller extends GetxController {
  void sendNotification(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'welcome',
          title: 'Welcome to Society Acts',
          body:
              'You are very welcome to Society Acts App.\nThe app that sends u to the Society.'),
    );
    AwesomeNotifications().displayedStream;
    AwesomeNotifications().actionStream.listen((event) {
      // Get.to(new SplashScreen());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return new SplashScreen();
      }));
    });
  }
}
