import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);

        if (barcodeScanRes == '-1') return; // !if press cancel => exit

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final newScan = await scanListProvider.newScan(barcodeScanRes);
        launchURL(context, newScan);
      },
      child: Icon(Icons.center_focus_strong),
    );
  }
}
