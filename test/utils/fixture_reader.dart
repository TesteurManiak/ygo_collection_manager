import 'dart:io' show File;

String fixture(String name) =>
    File('test/test_resources/$name').readAsStringSync();
