import 'package:alert_notification/alert_notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationWindow extends StatefulWidget {
  @override
  _NotificationWindowState createState() => _NotificationWindowState();
}

class _NotificationWindowState extends State<NotificationWindow> {
  List<String> notifications1 = [];
  List<String> notifications2 = [];

  var SolutionLevelRef = FirebaseDatabase.instance.ref("Solution Level");

  var PHLEVELRef = FirebaseDatabase.instance.ref("pH Alert");

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    setupNotificationListener();
  }

  void setupNotificationListener() {
    SolutionLevelRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          notifications1 =
              data.values.map<String>((value) => value.toString()).toList();
        });
      }
    }, onError: (error) {
      // Handle any error that occurred while listening to the notifications
      print('Error listening to notifications: $error');
    });

    PHLEVELRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          notifications2 =
              data.values.map<String>((value) => value.toString()).toList();
        });
      }
    }, onError: (error) {
      // Handle any error that occurred while listening to the notifications
      print('Error listening to notifications: $error');
    });
  }

  void fetchNotifications() {
    SolutionLevelRef.once().then((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          notifications1 =
              data.values.map<String>((value) => value.toString()).toList();
        });
      }
    }).catchError((error) {
      // Handle any error that occurred while fetching the notifications
      print('Error fetching notifications: $error');
    });

    PHLEVELRef.once().then((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          notifications2 =
              data.values.map<String>((value) => value.toString()).toList();
        });
      }
    }).catchError((error) {
      // Handle any error that occurred while fetching the notifications
      print('Error fetching notifications: $error');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var notification in notifications1)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      if (notification ==
                          'Normal Level') // Condition for low notification
                        AlertNotification(
                          title: 'Solution Level',
                          body: notification ?? 'null notification',
                          type: AlertNotificationType.success,
                        ),
                      if (notification ==
                          'Low Level') // Condition for high notification
                        AlertNotification(
                          title: 'Solutiion Level',
                          //body: notification ?? 'null notification',
                          body: 'Alert: ${notification ?? 'null notification'}',
                          type: AlertNotificationType.error,
                        ),
                    ],
                  ),
                for (var notification in notifications2)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      if (notification ==
                          'Normal pH') // Condition for low notification
                        AlertNotification(
                          title: 'PH Alert',
                          body: notification ?? 'null notification',
                          type: AlertNotificationType.success,
                        ),
                      if (notification ==
                          'High pH') // Condition for high notification
                        AlertNotification(
                          title: 'PH Alert',
                          body: 'Alert: ${notification ?? 'null notification'}',
                          type: AlertNotificationType.error,
                        ),
                      if (notification ==
                          'Low pH') // Condition for high notification
                        AlertNotification(
                          title: 'PH Alert',
                          body: 'Alert: ${notification ?? 'null notification'}',
                          type: AlertNotificationType.error,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
