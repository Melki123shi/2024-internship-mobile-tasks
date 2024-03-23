import 'dart:convert';
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

List<String> fixtureList(String name) {
  final fileContent = File('test/fixtures/$name').readAsStringSync();
  final jsonArray = json.decode(fileContent) as List<dynamic>;
  return jsonArray.map((item) => json.encode(item)).toList();
}
