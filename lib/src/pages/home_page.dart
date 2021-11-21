import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';

import 'package:qr_reader/src/widgets/bottom_navigation.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';

import 'package:qr_reader/src/pages/sites_page.dart';
import 'package:qr_reader/src/pages/maps_history_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('QR Reader'),
        actions: [
          IconButton(
              onPressed: () =>
                  Provider.of<ScanListProvider>(context, listen: false)
                      .deleteAll(),
              icon: Icon(Icons.delete_forever, color: Colors.white70)),
        ],
      ),
      body: _HomePageBody(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ?Get Selected Menu Option
    final uiProvider = Provider.of<UiProvider>(context);

    // ?Read Current index to display page index selected
    final currentIndex = uiProvider.selectedMenuOpt;

    // ?Use ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return MapsHistoryPage();

      case 1:
        scanListProvider.loadScansByType('http');
        return SitesPage();

      default:
        return MapsHistoryPage();
    }
  }
}
