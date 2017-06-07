// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS d.file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../descriptor.dart' as d;
import '../serve/utils.dart';
import '../test_pub.dart';

main() {
  test("does not compile if dart2js is disabled", () async {
    await d.dir(appPath, [
      d.appPubspec(),
      d.dir("web", [d.file("main.dart", "void main() => print('hello');")])
    ]).create();

    await pubGet();
    await pubServe(args: ["--no-dart2js"]);
    await requestShould404("main.dart.js");
    await endPubServe();
  });
}
