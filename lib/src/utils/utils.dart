import 'package:flutter/material.dart';

import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final _url = scan.value;

  final AlertDialog alert = AlertDialog(
    actionsAlignment: MainAxisAlignment.center,
    actions: [OkButton()],
    title: Text('Error!'),
    content: Text("Sorry can't save and open this QR Code."),
  );

  if (scan.type == 'http') {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  } else if (scan.type == 'geo') {
    Navigator.pushNamed(context, 'map', arguments: scan);
  } else {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

class OkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).toggleableActiveColor),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'OK',
          style: TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.bold),
        ));
  }
}
