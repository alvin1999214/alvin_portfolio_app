import 'package:flutter/material.dart';

void showAccessFailDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible:
          false, // disables popup to close if tapped outside popup (need a button to close)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Invalid Access Token",
          ),
          content: Text("Please check the access key is valid"),
          //buttons?
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              }, //closes popup
            ),
          ],
        );
      });
}

void showEmptyAccessKeyDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible:
          false, // disables popup to close if tapped outside popup (need a button to close)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Access Token is Empty",
          ),
          content: Text("Please enter the access key"),
          //buttons?
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              }, //closes popup
            ),
          ],
        );
      });
}
