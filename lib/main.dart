import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path/path.dart' as path;

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
  static const _initialUrl = 'https://www.google.com/?hl=ja';

  WebViewController _webViewController;

  void onPageStarted(String originalUriString) {
    //
    //
    try {
      final originalUri = Uri.parse(originalUriString);
      final ext = path.extension(originalUri.path);

      print('ext: $ext');

      if (ext == '.pdf' && Platform.isAndroid) {
        //
        // https:///viewer?url=
        //
        final redirectUrl = Uri.https(
          'docs.google.com',
          '/viewer',
          {
            'url': originalUriString
          }
        );

        print('redirect to $redirectUrl');
        _webViewController?.loadUrl(redirectUrl.toString());
      }

    } catch (error) {
      //
      print('parse error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: WebView(
              initialUrl: _WebViewPageState._initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) =>
                  _webViewController = webViewController,
              onPageStarted: onPageStarted,
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
