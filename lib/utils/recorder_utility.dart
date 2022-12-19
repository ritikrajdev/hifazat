import 'dart:async';
import 'dart:io';

import 'package:hifazat/utils/send_message_to_trusted_contacts.dart';
import 'package:hifazat/utils/web_util.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

Timer _timer = Timer(Duration.zero, () {});

void startListening() async {
  _timer = Timer.periodic(const Duration(seconds: 6), (timer) async {
    final record = Record();

    Directory? tmpDir = await getExternalStorageDirectory();
    String recordingPath = '${tmpDir?.path}/${randomAlpha(20)}.m4a';

    if (await record.hasPermission()) {
      print(DateTime.now().second);
      await record.start(path: recordingPath);
    }

    Timer(const Duration(seconds: 4), () async {
      print(DateTime.now().second);
      await record.stop();
      bool ijScream = await isScream(recordingPath);
      File(recordingPath).delete();
      print("Is Scream: ${ijScream}");
      if (ijScream) {
        sendMessageToTrustedContacts();
      }
    });

    print(recordingPath);
  });
}

void stopListening() async {
  _timer.cancel();
  print("Stopped");
}
