import 'package:dart_mappable/dart_mappable.dart';

part 'service_availability_block_model.mapper.dart';

@MappableClass()
class ServiceAvailabilityBlockModel with ServiceAvailabilityBlockModelMappable {
  const ServiceAvailabilityBlockModel({
    required this.id,
    required this.staffId,
    required this.startAt,
    required this.endAt,
    required this.createdAt,
    this.reason,
  });

  final String id;

  @MappableField(key: 'staff_id')
  final String staffId;

  @MappableField(key: 'start_at')
  final DateTime startAt;

  @MappableField(key: 'end_at')
  final DateTime endAt;

  final String? reason;

  @MappableField(key: 'created_at')
  final DateTime createdAt;

  String get providerId => staffId;

  String get dateKey {
    final date = startAt.toLocal();
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  int get startMinutes {
    final date = startAt.toLocal();
    return date.hour * 60 + date.minute;
  }
}
