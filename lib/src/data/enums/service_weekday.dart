import 'package:dart_mappable/dart_mappable.dart';

part 'service_weekday.mapper.dart';

@MappableEnum()
enum ServiceWeekday {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  const ServiceWeekday(this.label);

  final String label;
}
