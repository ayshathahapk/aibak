import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class RateAlert extends StatefulWidget {
  const RateAlert({super.key});

  @override
  State<RateAlert> createState() => _RateAlertState();
}

class _RateAlertState extends State<RateAlert> {
  double _progress=0;
  final uri = Uri.parse("https://aurifyae.github.io/aibak-app/ratealert.html");
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(uri),
              ),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
