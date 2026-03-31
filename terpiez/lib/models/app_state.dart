import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class AppState extends ChangeNotifier {
  AppState()
      : startDate = DateTime.now(),
        userId = const Uuid().v4();

  int _terpiezCaught = 0;

  int get terpiezCaught => _terpiezCaught;

  final DateTime startDate;
  final String userId;

  int get daysPlayed => DateTime.now().difference(startDate).inDays;

  void setTerpiezCaught(int value) {
    if (_terpiezCaught == value) {
      return;
    }

    _terpiezCaught = value;
    notifyListeners();
  }

  void incrementTerpiezCaught() {
    _terpiezCaught += 1;
    notifyListeners();
  }
}
