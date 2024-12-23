import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/Spalsh%20Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kompanyon_app/theme.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/view/notification_screen/notification.dart';
import 'package:kompanyon_app/view/search_screen/search_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'firebase_options.dart';
import 'helper/bindings.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  await initLocalStorage();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _listenersInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        _navigateToNotificationsScreen();
      },
    );

    if (!_listenersInitialized) {
      // Request permission for iOS devices
      _firebaseMessaging.requestPermission();

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received a message in the foreground: ${message.data}');
        _handleForegroundNotification(message);
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Handle notification taps when the app is in the background or terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Notification was tapped!');
        _navigateToNotificationsScreen();
      });

      // Check if app was opened from a terminated state via a notification
      _checkForInitialMessage();

      _listenersInitialized = true;
    }
  }

  Future<void> _checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _navigateToNotificationsScreen();
    }
  }

  Future<void> _handleForegroundNotification(RemoteMessage message) async {
    // Check if the app is in the foreground
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      // Suppress "Chat Message" notifications in the foreground

      // Show other notifications in the foreground
      _showNotification(message);
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    // Print title and body
    print('Notification Title: ${message.notification?.title}');
    print('Notification Body: ${message.notification?.body}');

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id', // Make sure to use a unique channel ID
        'your_channel_name', // Channel name
        channelDescription: 'Your channel description',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: 'data',
    );
  }

  // Method to navigate to Notifications screen
  void _navigateToNotificationsScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (_, child) {
          return GetMaterialApp(
            routes: {
              '/home': (context) => HomeScreen(),
              '/search': (context) => SearchScreen(),
              // Add other routes here
            },
            theme: ThemeManager.currentTheme,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            initialBinding: UserBinding(),
          );
        });
  }
}
