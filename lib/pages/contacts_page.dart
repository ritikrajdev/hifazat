import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:hifazat/components/hifazat_scaffold.dart';
import 'package:hifazat/globals.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  void addContact() async {
    if (!await FlutterContactPicker.hasPermission()) {
      if (!await FlutterContactPicker.requestPermission()) {
        SystemNavigator.pop();
      }
    }

    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();

    setState(() {
      trustedContacts.add(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> trustedContactCards = trustedContacts
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 325,
            height: 48,
            color: const Color(0xFFEFEFEF),
            alignment: Alignment.center,
            child: Text(e.fullName ?? "Oops - None"),
          ),
        )
        .toList();

    return HifazatScaffold(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                GestureDetector(
                  onTap: addContact,
                  child: Container(
                    width: 325,
                    height: 48,
                    color: const Color(0xFFEFEFEF),
                    alignment: Alignment.center,
                    child: const Text("Select Contact to Trust"),
                  ),
                ),
                Container(
                  height: 50,
                ),
              ] +
              trustedContactCards,
        ),
      ),
    );
  }
}
