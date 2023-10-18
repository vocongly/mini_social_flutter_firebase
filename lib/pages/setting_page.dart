import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mini_social/provider/theme_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ligh Mode/Dark Mode'),
                IconButton(
                    onPressed: () {
                     Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                      print('change themedata');
                    },
                    icon: const Icon(Icons.swap_vert_circle_sharp))
              ],
            ),
            Divider(
              height: 2,
              color: Theme.of(context).colorScheme.inversePrimary,
            )
          ],
        ),
      ),
    );
  }
}
