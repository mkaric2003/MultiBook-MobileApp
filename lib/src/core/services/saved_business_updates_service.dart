import 'dart:async';
import 'package:injectable/injectable.dart';

@lazySingleton
class SavedBusinessUpdatesService {
  final StreamController<void> _changes = StreamController<void>.broadcast();
  Stream<void> get changes => _changes.stream;
  void notifyChanged() => _changes.add(null);
}
