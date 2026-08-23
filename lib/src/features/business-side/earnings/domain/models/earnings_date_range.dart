import 'package:flutter/material.dart';

class EarningsDateRange {
  const EarningsDateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  DateTimeRange get asDateTimeRange => DateTimeRange(start: start, end: end);
}
