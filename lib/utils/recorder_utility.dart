import 'dart:async';
import 'dart:io';

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

Timer _timer = Timer(Duration.zero, () {});

void startListening() async {
  _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
    final record = Record();

    Directory? tmpDir = await getExternalStorageDirectory();
    String recordingPath = '${tmpDir?.path}/xyz.m4a';

    if (await record.hasPermission()) {
      print(DateTime.now().second);
      await record.start(
        path: recordingPath,
      );
    }

    Timer(const Duration(seconds: 4), () async {
      print(DateTime.now().second);
      await record.stop();
    });

    print(recordingPath);
  });
}

void stopListening () async {
  _timer.cancel();
  print("Stopped");
}
