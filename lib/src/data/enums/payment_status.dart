import 'package:dart_mappable/dart_mappable.dart';

part 'payment_status.mapper.dart';

@MappableEnum()
enum PaymentStatus { paid, pending, failed, refunded }
