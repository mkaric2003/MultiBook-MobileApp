import 'dart:async';

import 'package:injectable/injectable.dart';

/// Owns Firestore subscriptions that are tied to the authenticated session.
///
/// A Firebase Auth sign-out revokes Firestore access immediately. Cancelling
/// registered subscriptions first prevents those streams from receiving a
/// permission-denied event during the sign-out transition.
@lazySingleton
class SessionStreamRegistry {
  final Set<StreamSubscription> _subscriptions = {};
  bool _isEndingSession = false;

  void register(StreamSubscription subscription) {
    if (_isEndingSession) {
      unawaited(subscription.cancel());
      return;
    }
    _subscriptions.add(subscription);
  }

  void unregister(StreamSubscription? subscription) {
    if (subscription != null) {
      _subscriptions.remove(subscription);
    }
  }

  Future<void> cancelAll() async {
    _isEndingSession = true;
    final subscriptions = _subscriptions.toList(growable: false);
    _subscriptions.clear();
    await Future.wait(
      subscriptions.map((subscription) => subscription.cancel()),
    );
  }

  void beginSession() {
    _isEndingSession = false;
  }
}
