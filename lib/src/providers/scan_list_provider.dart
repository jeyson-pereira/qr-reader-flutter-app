// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String selectedType = 'http';

  // *insert new scan
  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);

    // Set id from DB to the newScan model
    newScan.id = id;

    if (this.selectedType == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  // *load all scans
  loadScans() async {
    final scans = await DBProvider.db.getAllScan();
    this.scans = [...scans!];

    notifyListeners();
  }

  // *load scans by type
  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans!];
    this.selectedType = type;

    notifyListeners();
  }

  // *delete all scans
  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];

    notifyListeners();
  }

  // *delete scan by id
  deleteScanbyId(int id) async {
    await DBProvider.db.deleteScan(id);
    this.loadScansByType(this.selectedType);
  }
}
