import 'package:flutter/material.dart';

import '../database/db_sqflite.dart';
import '../global/const.dart';

class ChatData with ChangeNotifier {
  Map<String, int> _lastSeen = {};

  ChatData(
    this._lastSeen,
  );

  void updateStatus(String roomId, int timeStampMS) {
    _lastSeen[roomId] = timeStampMS;
    notifyListeners();
  }

  void addToDB() {
    _lastSeen.forEach(
      (key, value) {
        DBHelper.insert(Tables.lastSeen, {'roomId': key, 'timeStampMS': value});
      },
    );
  }

  void readDB() async {
    final lastSeenDBList = await DBHelper.getChatData(Tables.lastSeen);
    if (lastSeenDBList.isNotEmpty) {
      lastSeenDBList.forEach((element) {
        _lastSeen[element['roomId']] = element['timeStampMS'];
      });
    }
    notifyListeners();
  }

  int? lastSeen(String roomId) {
    return _lastSeen[roomId];
  }

  Map<String, int> get getLastSeen {
    return _lastSeen;
  }

  bool showBadge(int? timestamp, String id) {
    if (timestamp != null && _lastSeen[id] != null) if (timestamp >=
        _lastSeen[id]!) return true;
    return false;
  }
}
