import 'package:equatable/equatable.dart';

enum SortByMode {
  latestPosted,
  earliestPosted,
  latestPublished,
  earliestPublished,
}

class OrderBy extends Equatable {
  const OrderBy({required this.fieldName, required this.descending});

  final String fieldName;
  final bool descending;

  @override
  List<Object?> get props => [fieldName, descending];

  @override
  String toString() =>
      'OrderBy {fieldName: $fieldName, descending: $descending}';
}

extension SortByExtension on SortByMode {
  static const headers = {
    SortByMode.latestPosted: 'Latest Image',
    SortByMode.earliestPosted: 'Earliest Image',
    SortByMode.latestPublished: 'Latest Published Image',
    SortByMode.earliestPublished: 'Earliest Published Image',
  };

  static const queries = {
    SortByMode.latestPosted: OrderBy(fieldName: 'timestamp', descending: true),
    SortByMode.earliestPosted:
      OrderBy(fieldName: 'timestamp', descending: false),
    SortByMode.latestPublished:
      OrderBy(fieldName: 'published', descending: true),
    SortByMode.earliestPublished:
      OrderBy(fieldName: 'published', descending: false),
  };

  String get header => headers[this] ?? 'Unknown';
  OrderBy get query =>
      queries[this] ?? const OrderBy(fieldName: 'published', descending: true);
}
