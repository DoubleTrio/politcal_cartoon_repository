import 'package:flutter_test/flutter_test.dart';

import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  var fire = FirebasePoliticalCartoonRepository();
  fire.getPoliticalCartoonById('NhHXTz1cIISIDjzr0NiQ').then((value) => print(value));
}
