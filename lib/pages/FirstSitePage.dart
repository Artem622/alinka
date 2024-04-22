import 'dart:io';

import 'package:alinka/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/APIProvider.dart';

class FirstSitePage extends StatefulWidget {
  const FirstSitePage({super.key});

  @override
  State<FirstSitePage> createState() => _FirstSitePageState();
}

class _FirstSitePageState extends State<FirstSitePage> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;
  int _selectedIndex = 0;
  bool isStarted = false;
  bool isOpened = false;

  final initialSettings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    iframeAllow: "camera; microphone",
    isInspectable: false,
    useOnDownloadStart: true,
      useOnLoadResource:true,
  javaScriptCanOpenWindowsAutomatically:true,
  userAgent:
  "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
  transparentBackground:true,
  disableDefaultErrorPage:true,
      verticalScrollbarThumbColor:
      const Color.fromRGBO(0, 0, 0, 0.5),
  horizontalScrollbarThumbColor:
  const Color.fromRGBO(0, 0, 0, 0.5),

  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if(index == 0) {
      setState(() {
        isStarted = !isStarted;
      });
      if(isStarted) {
        // когда нужно стопнуть
        webViewController.evaluateJavascript(source: 'alert("Stop")');
      } else {
        // когда нужно стартнуть
        webViewController.evaluateJavascript(source: 'alert("Start")');
      }
    } else if(index == 1) {
      // рефреш
      webViewController.evaluateJavascript(source: 'alert("Refresh")');
    } else if(index == 2) {
      setState(() {
        isOpened = !isOpened;
      });
      if(isOpened) {
        // когда нужно закрыть
        webViewController.evaluateJavascript(source: 'alert("Close")');
      } else {
        // когда нужно открыть
        webViewController.evaluateJavascript(source: 'alert("Open")');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Alinka"),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text(!isStarted ? "Stop" : "Start"),
            label: 'Start/Stop',
          ),
          const BottomNavigationBarItem(
            icon: Text("Refresh"),
            label: 'Refresh',
          ),
          BottomNavigationBarItem(
            icon: Text(!isOpened ? "Close" : "Open"),
            label: 'Open/Close',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: InAppWebView(

          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri(firstUrl)),
          initialSettings: initialSettings,

        onPermissionRequest: (controller, permissionRequest) async {
          return PermissionResponse(
              resources: permissionRequest.resources,
              action: PermissionResponseAction.GRANT);
        },

        onWebViewCreated: (controller) async {
          webViewController = controller;
        },

        onLoadStop: (controller, url) {
            print('LOADED INITIAL SCRIPT');
          webViewController.evaluateJavascript(source: '(() => {if (document.querySelector("div.chat_broadcast")) console.log("drochila228 startDrochila")})()');
        },

        onConsoleMessage: (controller, message) async{
          final gotMessage = message.message;
          print(message);
          if(RegExp('drochila228 startDrochila', multiLine: true).hasMatch(gotMessage)){
            print('LOADED INITIAL SCRIPT');
            webViewController.evaluateJavascript(source: mess);
          }
          else if (RegExp('drochila228', multiLine: true).hasMatch(gotMessage)) {
            var temp1 = gotMessage.split(' ');
            print(temp1);
            var url = temp1[1];
            print(url);
            temp1 = temp1.sublist(2);
            print(temp1);

            final answer = await APIProvider().firstRequest(url, temp1.join(" "));
            print('tetebg');
            print(answer);

            var answer2 = answer.replaceAll('`', "'");

            webViewController.evaluateJavascript(
            source: '(() => {document.getElementById("HOLDER_DIV").innerText = `$answer2`})()');

            }
          }
      ),
    );
  }
}
