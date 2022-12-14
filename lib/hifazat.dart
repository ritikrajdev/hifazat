import 'package:flutter/material.dart';
import 'package:hifazat/constants/general.dart';
import 'package:hifazat/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class Hifazat extends StatelessWidget {
  const Hifazat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
