import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebView")),
      body: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  //
  // static const _initialUrl = 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.ohsho.co.jp%2Fmenu%2Fpdf%2Fallergy.pdf';
  static const _initialUrl = 'https://www.ohsho.co.jp/menu/';

  WebViewController _webViewController;

  // void onPageStarted(String originalUriString) {
  //   //
  //   //

  // }

  Uri _pendingLoadUri;
  // Timer _timer;

  Future<NavigationDecision> onNavigationDelegate(NavigationRequest request) async {
    //
    //
    print('DEBUG: onNavigationDelegate $request');

    // return NavigationDecision.prevent;
    try {
      final originalUri = Uri.parse(request.url);
      final ext = path.extension(originalUri.path);

      print('DEBUG: $originalUri ext: $ext');

      if (ext == '.pdf' && Platform.isAndroid) {
        print('DEBUG: isPDF and isAndroid');

        //
        _pendingLoadUri = Uri.https(
          'docs.google.com',
          '/viewer',
          {
            'url': originalUri.toString(),
          },
        );

        // _timer?.cancel();
        // _timer = Timer(Duration(milliseconds: 300), onTimer);
        print('DEBUG: loadUrl ${_pendingLoadUri.toString()}');
        await _webViewController?.loadUrl(_pendingLoadUri.toString());
        return NavigationDecision.prevent;
      }
    } catch (error) {
      //
      print('parse error: $error');
    }

    return NavigationDecision.navigate;
  }

  // void onTimer() async {
  //   //
  //   _timer = null;
  //   print('DEBUG: onTimer');
  //   if (_pendingLoadUri != null) {
  //     print('DEBUG: loadUrl ${_pendingLoadUri.toString()}');
  //     await _webViewController?.loadUrl(_pendingLoadUri.toString());
  //     // _webViewController?.loadUrl('https://google.com/');
  //     _pendingLoadUri = null;
  //   }
  // }

  // void onPageFinished(String uri) {
  //   print('DEBUG: onPageFinished redirectTo: ${_pendingLoadUri}');
  //   // if (_pendingLoadUri != null) {
  //   //   _webViewController?.loadUrl(_pendingLoadUri.toString());
  //   //   _pendingLoadUri = null;
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: WebView(
              initialUrl: _WebViewPageState._initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) => _webViewController = webViewController,
              onPageStarted: (_) => print('DEBUG: onPageStarted'),
              // onPageFinished: (_) => print('DEBUG: onPageFinished'), //onPageFinished,
              navigationDelegate: onNavigationDelegate,
            )),
        Container(
          color: Colors.white,
          height: 20,
          //省略
        ),
      ],
    );
  }
}

// class WebAndPdfViewController extends WebViewController{

//   //下記super部分でエラー
//   WebAndPdfViewController():super();
//   final String googleDocs = "https://docs.google.com/viewer?url=";
//   @override
//   Future<void> loadUrl(String url, {Map<String, String> headers}){
//     final String newUrl = createLoadUrl(url);
//     return super.loadUrl(newUrl, headers);
//   }

//   String createLoadUrl(String url) {
//     if (Platform.isAndroid) {
//       return googleDocs + url;
//     } else {
//       return url;
//     }
//   }

// }
