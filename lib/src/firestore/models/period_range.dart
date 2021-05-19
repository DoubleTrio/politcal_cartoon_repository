import 'package:equatable/equatable.dart';

class PeriodRange extends Equatable {
  const PeriodRange(this.startDate, this.endDate, {this.isValidPeriod = true});

  final int startDate;
  final int endDate;
  final bool isValidPeriod;

  @override
  List<Object?> get props => [startDate, endDate, isValidPeriod];

  @override
  String toString() =>
    'PeriodRange($startDate, $endDate, { isValidPeriod: $isValidPeriod })';

  String format() => '$startDate-$endDate';
}
