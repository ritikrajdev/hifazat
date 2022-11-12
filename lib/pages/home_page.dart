import 'package:flutter/material.dart';
import 'package:hifazat/components/hifazat_scaffold.dart';
import 'package:hifazat/utils/send_message_to_trusted_contacts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var canListenToScream = false;

  void toggleScreamDetection() {
    setState(() {
      canListenToScream = !canListenToScream;
      if (canListenToScream) {
        sendMessageToTrustedContacts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String imagePath =
        "assets/images/${canListenToScream ? "on.png" : "off.png"}";
    return HifazatScaffold(
      child: GestureDetector(
        onTap: toggleScreamDetection,
        child: Image.asset(imagePath),
      ),
    );
  }
}
