// ignore_for_file: unused_import

import 'package:BuMo/firebase_options.dart';
import 'package:BuMo/models/rider_account.dart';
import 'package:BuMo/screens/driver-side/driver_maps_screen.dart';
import 'package:BuMo/screens/landing_screen.dart';
import 'package:BuMo/screens/login_screen.dart';
import 'package:BuMo/screens/messaging/chat_screen.dart';
import 'package:BuMo/screens/messaging/inbox_screen.dart';
import 'package:BuMo/screens/messaging/login_temp.dart';
import 'package:BuMo/screens/on-boarding_screen.dart';
import 'package:BuMo/screens/registration/driver_details.dart';
import 'package:BuMo/screens/registration/rider_details.dart';
import 'package:BuMo/screens/rider-side/driver_rating_screen.dart';
import 'package:BuMo/screens/rider-side/rider_maps_screen.dart';
import 'package:BuMo/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuMo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: DriverRatingScreen(),
    );
  }
}
