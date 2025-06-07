import 'package:flutter/material.dart';
import '../models/report.dart';
import '../db/order_db.dart';

class ReportProvider with ChangeNotifier {
  Future<void> submitReport(Report report) async {
    await OrderDatabase.instance.insertReport(report);
    notifyListeners();
  }
}
