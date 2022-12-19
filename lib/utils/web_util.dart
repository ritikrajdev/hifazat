import 'dart:convert';

import 'package:http/http.dart';
import 'dart:io';
import 'package:path/path.dart';

Future<bool> isScream(filePath) async {
  print("isScream Function");

  File file = File(filePath);
  print(file.lengthSync());
  var uri = 'http://15.207.114.117/';
  var request = MultipartRequest('POST', Uri.parse(uri));
  request.files.add(MultipartFile(
    'file',
    file.readAsBytes().asStream(),
    file.lengthSync(),
    filename: basename(filePath),
  ));

  var response = await request.send();
  final res = jsonDecode(await response.stream.bytesToString());
  print(res);

  return res['scream'];
}
