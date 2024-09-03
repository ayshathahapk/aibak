import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  double _progress=0;
  final uri = Uri.parse("https://aurifyae.github.io/aibak-app/graph.html");
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