import 'package:dart_mappable/dart_mappable.dart';

part 'service_provider_model.mapper.dart';

@MappableClass()
class ServiceProviderModel with ServiceProviderModelMappable {
  const ServiceProviderModel({required this.name, this.title});

  final String name;
  final String? title;
}
