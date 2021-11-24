import 'dart:convert';
import 'dart:io' show File;

String readFileStringSync(String name) =>
    File('test/test_resources/$name').readAsStringSync();

Future<String> readFileStringAsync(String name) =>
    File('test/test_resources/$name').readAsString();

Future<T> readFileJsonAsync<T>(String name) =>
    readFileStringAsync(name).then((String json) => jsonDecode(json) as T);
