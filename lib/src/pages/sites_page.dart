import 'package:flutter/material.dart';
import 'package:qr_reader/src/widgets/scan_tiles.dart';

class SitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTiles(type: 'http');
  }
}
