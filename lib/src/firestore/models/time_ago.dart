import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TimeConverter {
  const TimeConverter({this.locale = 'en'});

  final String locale;

  String timeAgoSinceDate(Timestamp timestamp, {bool numericDates = true});
}
