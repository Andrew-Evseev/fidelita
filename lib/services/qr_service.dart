import 'package:flutter/foundation.dart';

class QrService with ChangeNotifier {
  String? _lastScannedQr;
  List<String> _scanHistory = [];

  String? get lastScannedQr => _lastScannedQr;
  List<String> get scanHistory => _scanHistory;

  void scanQrCode(String qrData) {
    _lastScannedQr = qrData;
    _scanHistory.add(qrData);
    notifyListeners();
  }

  void clearHistory() {
    _scanHistory.clear();
    _lastScannedQr = null;
    notifyListeners();
  }
}