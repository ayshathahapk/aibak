import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TrendAnalysis extends StatefulWidget {
  const TrendAnalysis({super.key});

  @override
  State<TrendAnalysis> createState() => _TrendAnalysisState();
}

class _TrendAnalysisState extends State<TrendAnalysis> {
  double _progress=0;
  final uri = Uri.parse("https://aurifyae.github.io/aibak-app/trendanalysis.html");
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Color(0xFFD3AF37)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),        body: Stack(
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
