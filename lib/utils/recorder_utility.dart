import 'dart:async';
import 'dart:io';

import 'package:hifazat/utils/send_message_to_trusted_contacts.dart';
import 'package:hifazat/utils/web_util.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';
import 'package:vibration/vibration.dart';

Timer _timer = Timer(Duration.zero, () {});

void startListening() async {
  _timer = Timer.periodic(const Duration(seconds: 6), (timer) async {
    final record = Record();

    Directory? tmpDir = await getExternalStorageDirectory();
    String recordingPath = '${tmpDir?.path}/${randomAlpha(20)}.m4a';

    if (await record.hasPermission()) {
      print(DateTime.now().second);
      await record.start(path: recordingPath, bitRate: 22050);
    }

    Timer(const Duration(seconds: 4), () async {
      print(DateTime.now().second);
      await record.stop();
      bool ijScream = await isScream(recordingPath);
      File(recordingPath).delete();
      if (ijScream) {
        print("Is Scream: ${ijScream}");
        sendMessageToTrustedContacts();
        var hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator ?? false) {
          Vibration.vibrate(pattern: [500, 500, 500, 500]);
        }
      }
    });

    print(recordingPath);
  });
}

void stopListening() async {
  _timer.cancel();
  print("Stopped");
}
