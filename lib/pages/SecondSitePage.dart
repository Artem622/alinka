import 'package:alinka/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../utils/APIProvider.dart';

class SecondSitePage extends StatefulWidget {
  const SecondSitePage({super.key});

  @override
  State<SecondSitePage> createState() => _SecondSitePageState();
}

class _SecondSitePageState extends State<SecondSitePage> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;
  int _selectedIndex = 0;

  final settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text("1"),
            label: '1',
          ),
          BottomNavigationBarItem(
            icon: Text("2"),
            label: '2',
          ),
          BottomNavigationBarItem(
            icon: Text("3"),
            label: '3',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: WebUri(secondUrl)),
        initialSettings: settings,
        onWebViewCreated: (controller) => {webViewController = controller},
        onConsoleMessage: (controller, message) async {
          final gotMessage = message.message;
          if (gotMessage == "Something we track") {
            final answer = await APIProvider().firstRequest('reply', gotMessage);

            if(answer == "success") {
              webViewController.evaluateJavascript(
                  source: '$answer');
            }
          }
        },
      ),
    );
  }
}
