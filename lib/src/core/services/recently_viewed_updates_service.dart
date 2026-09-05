import 'dart:async';

import 'package:injectable/injectable.dart';

@lazySingleton
class RecentlyViewedUpdatesService {
  final StreamController<void> _changes = StreamController<void>.broadcast();

  Stream<void> get changes => _changes.stream;

  void notifyChanged() => _changes.add(null);
}
