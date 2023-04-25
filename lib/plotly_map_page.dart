import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlotlyMapPage extends StatefulWidget {
  @override
  _PlotlyMapPageState createState() => _PlotlyMapPageState();
}

class _PlotlyMapPageState extends State<PlotlyMapPage> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plotly Map')),
      body: FutureBuilder<String>(
        future: _loadLocalHTML(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _controller?.loadUrl(Uri.dataFromString(snapshot.data!, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading HTML'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<String> _loadLocalHTML() async {
    return await rootBundle.loadString('05-NW-0.0to100.0-above0.0winval100.0.html');
  }
}
