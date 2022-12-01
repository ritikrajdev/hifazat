import 'dart:convert';

import 'package:http/http.dart';
import 'dart:io';
import 'package:path/path.dart';

Future<bool> isScream(filePath) async {
  print("isScream Function");

  File file = File(filePath);
  print(file.lengthSync());
  var uri = 'http://336a-34-70-173-120.ngrok.io';
  var request = MultipartRequest('POST', Uri.parse(uri));
  request.files.add(MultipartFile(
    'file',
    file.readAsBytes().asStream(),
    file.lengthSync(),
    filename: basename(filePath),
  ));

  var response = await request.send();
  final res = jsonDecode(await response.stream.bytesToString());

  return res['scream'];
}
