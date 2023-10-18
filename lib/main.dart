import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_social/auth/auth_page.dart';
import 'package:flutter_mini_social/auth/login_or_register.dart';
import 'package:flutter_mini_social/firebase_options.dart';
import 'package:flutter_mini_social/pages/home_page.dart';
import 'package:flutter_mini_social/pages/profile_page.dart';
import 'package:flutter_mini_social/pages/setting_page.dart';
import 'package:flutter_mini_social/pages/user_page.dart';
import 'package:flutter_mini_social/provider/theme_provider.dart';
import 'package:flutter_mini_social/theme/dark_mode.dart';
import 'package:flutter_mini_social/theme/light_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/user_page': (context) => const UserPage(),
        '/setting_page': (context) => const SettingPage(),
      },
    );
  }
}
