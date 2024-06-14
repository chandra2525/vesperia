import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  // final String url;

  // WebPage({required this.url});

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    // ..setNavigationDelegate(
    //   NavigationDelegate(
    //     onProgress: (int progress) {
    //       // Update loading bar.
    //     },
    //     onPageStarted: (String url) {},
    //     onPageFinished: (String url) {},
    //     onWebResourceError: (WebResourceError error) {},
    //     onNavigationRequest: (NavigationRequest request) {
    //       if (request.url.startsWith('https://www.youtube.com/')) {
    //         return NavigationDecision.prevent;
    //       }
    //       return NavigationDecision.navigate;
    //     },
    //   ),
    // )
    ..loadRequest(Uri.parse('https://www.youtube.com/watch?v=lpnKWK-KEYs'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webpage'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
