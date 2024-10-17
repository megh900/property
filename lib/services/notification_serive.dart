import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Store your server key in an environment variable or secure storage in production
  static const String serverKey = String.fromEnvironment('FCM_SERVER_KEY', defaultValue: 'YOUR_SERVER_KEY_HERE');

  // Initialize the notification service
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: onSelectNotification);

    await requestNotificationPermission();

    // Set auto initialization for messaging
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // Listen for notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // Handle background and terminated state messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle notification click when the app is opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification opened: ${message.data}');
      // Implement any navigation logic if necessary
    });
  }

  // Handle background messages
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    _handleMessage(message);
  }

  // Request permission for notifications (important for iOS)
  static Future<void> requestNotificationPermission() async {
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Notification permission granted.');
    } else {
      print('Notification permission denied.');
    }
  }

  // Retrieve FCM token
  static Future<String?> getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('FCM Token: $token');
      } else {
        print('Failed to get FCM token.');
      }
      return token;
    } catch (e) {
      print('Error retrieving FCM token: $e');
      return null;
    }
  }

  // Handle incoming messages and display notifications
  static void _handleMessage(RemoteMessage message) {
    final String title = message.notification?.title ?? 'No Title';
    final String body = message.notification?.body ?? 'No Body';
    final String? imageUrl = message.data['image'];

    if (imageUrl != null) {
      _downloadAndShowImageNotification(title, body, imageUrl);
    } else {
      showNotification(title, body);
    }
  }

  // Display a simple notification
  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(0, title, body, platformDetails);
  }

  // Download image and display notification with image
  static Future<void> _downloadAndShowImageNotification(String title, String body, String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        print('Error downloading image: ${response.statusCode}');
        showNotification(title, body);
        return;
      }

      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/notification_image.jpg';
      File file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);

      final BigPictureStyleInformation bigPictureStyle =
      BigPictureStyleInformation(
        FilePathAndroidBitmap(filePath),
        contentTitle: title,
        summaryText: body,
      );

      final AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
        'image_channel_id',
        'Image Channel',
        styleInformation: bigPictureStyle,
        importance: Importance.max,
        priority: Priority.high,
      );

      final NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

      await _localNotificationsPlugin.show(0, title, body, platformDetails);
    } catch (e) {
      print('Error downloading or showing image notification: $e');
      showNotification(title, body);
    }
  }

  // Handle notification click
  static Future<void> onSelectNotification(NotificationResponse? response) async {
    if (response?.payload != null) {
      print('Notification payload: ${response!.payload}');
      // Implement navigation logic here
    }
  }

  // Send a push notification using FCM HTTP API
  static Future<void> sendPushNotification(String token, String title, String body, {String? imageUrl}) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final data = {
      'to': token,
      'notification': {
        'title': title,
        'body': body,
        'priority': 'high',
        if (imageUrl != null) 'image': imageUrl,
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'payload': {
          'title': title,
          'body': body,
        },
      },
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully.');
      } else {
        print('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
