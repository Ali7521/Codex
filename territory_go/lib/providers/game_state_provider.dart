import 'package:flutter/foundation.dart';

class GameStateProvider extends ChangeNotifier {
  int _playerXP = 1250;
  int _streakCount = 5;
  int _level = 4;
  
  // Dummy Challenges
  List<Map<String, dynamic>> _dailyChallenges = [
    {'title': 'Walk 5km', 'progress': 3.2, 'target': 5.0, 'completed': false},
    {'title': 'Capture 3 Zones', 'progress': 1, 'target': 3, 'completed': false},
    {'title': 'Maintain a speed > 10km/h for 5 mins', 'progress': 0, 'target': 1, 'completed': false},
  ];

  int get playerXP => _playerXP;
  int get streakCount => _streakCount;
  int get level => _level;
  List<Map<String, dynamic>> get dailyChallenges => _dailyChallenges;

  void addXP(int xp) {
    _playerXP += xp;
    // Basic level up logic could go here
    notifyListeners();
  }

  void incrementStreak() {
    _streakCount++;
    notifyListeners();
  }
}
