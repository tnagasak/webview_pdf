import 'dart:io';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text("WebView")),
      body: SamplePage(),
      );
  }
}

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  static const _initialUrl = 'https://www.google.com/?hl=ja';

  WebAndPdfViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: WebView(
              initialUrl: _SamplePageState._initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController){
                _controller = webViewController;
              },
            )),
        Container(
          color: Colors.white,
          height: 20,
          //省略
          ),
      ],);
  }
}

class WebAndPdfViewController extends WebViewController{

  //下記super部分でエラー
  WebAndPdfViewController():super();
  final String googleDocs = "https://docs.google.com/viewer?url=";
  @override
  Future<void> loadUrl(String url, {Map<String, String> headers}){
    final String newUrl = createLoadUrl(url);
    return super.loadUrl(newUrl, headers);
  }

  String createLoadUrl(String url) {
    if (Platform.isAndroid) {
      return googleDocs + url;
    } else {
      return url;
    }
  }

}
