import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hifazat/constants/colors.dart';
import 'package:hifazat/constants/general.dart';
import 'package:hifazat/pages/contacts_page.dart';
import 'package:hifazat/pages/home_page.dart';

class HifazatScaffold extends StatelessWidget {
  final Widget child;
  const HifazatScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34.0),
            child: Text(
              kAppName,
              style: GoogleFonts.kaushanScript(fontSize: 64),
            ),
          ),
          child,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.home,
                    color: kInactiveColor,
                    size: 42,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.contact_page,
                    color: kInactiveColor,
                    size: 42,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactsPage()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
