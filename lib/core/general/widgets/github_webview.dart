import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithumWebview extends StatefulWidget {
  const GithumWebview({super.key});

  @override
  State<GithumWebview> createState() => _GithumWebviewState();
}

class _GithumWebviewState extends State<GithumWebview> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("progess $progress");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://github-contributions-api.deno.dev/Thecodersuraj.svg'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 300, child: WebViewWidget(controller: controller));
  }
}
