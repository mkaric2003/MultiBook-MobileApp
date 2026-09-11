import 'package:dart_mappable/dart_mappable.dart';

part 'create_service_availability_block_request.mapper.dart';

@MappableClass()
class CreateServiceAvailabilityBlockRequest
    with CreateServiceAvailabilityBlockRequestMappable {
  const CreateServiceAvailabilityBlockRequest({
    required this.startAt,
    required this.endAt,
    this.reason,
  });

  @MappableField(key: 'start_at')
  final DateTime startAt;

  @MappableField(key: 'end_at')
  final DateTime endAt;

  final String? reason;
}
