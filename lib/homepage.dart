import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F1),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () => _goBack(context),
          child: WebView(
            initialUrl: 'https://live-brewdhawt.dmmotsqo77ifk.amplifyapp.com',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controllerCompleter.future.then((value) => _controller = value);
              _controllerCompleter.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('Do you want to exit'),
      //       actions: <Widget>[
      //         FlatButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('No'),
      //         ),
      //         FlatButton(
      //           onPressed: () {
      //             SystemNavigator.pop();
      //           },
      //           child: Text('Yes'),
      //         ),
      //       ],
      //     ));
      return Future.value(true);
    }
  }
}
