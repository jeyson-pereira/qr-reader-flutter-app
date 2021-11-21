import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final List<ScanModel> scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) =>
            Provider.of<ScanListProvider>(context, listen: false)
                .deleteScanbyId(scans[i].id), // !Delete ScanTile Dismissed
        background: _DismissContainer(),
        child: ListTile(
          leading: Icon(type == 'http' ? Icons.travel_explore : Icons.place,
              color: Theme.of(context).toggleableActiveColor.withOpacity(0.7)),
          title: Text(scans[i].value),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[i]),
        ),
      ),
    );
  }
}

class _DismissContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: Container(
        child: Icon(Icons.delete, color: Colors.white.withOpacity(0.7)),
        margin: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
