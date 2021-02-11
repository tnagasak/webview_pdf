import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WebViewPage(),
    );
  }
}

// class WebViewPageController {
//   //
//   WebViewController _webViewController;
//   WebViewPageController();

//   load() async {
//     final pdf = await PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf');

//   }
// }

// final webViewPageCtrlProvider = Provider.autoDispose<WebViewPageController>((ref) {
//   final ctrl = WebViewPageController();
//   // ref.onDispose(() => ctrl)
//   return ctrl;
// });

final pdfProvider = FutureProvider.family((ref, url) => PDFDocument.fromURL(url));

class WebViewPage extends ConsumerWidget {
  //
  // static const _initialUrl = 'https://docs.google.com/viewer?url=https%3A%2F%2Fwww.ohsho.co.jp%2Fmenu%2Fpdf%2Fallergy.pdf';
  // static const _initialUrl = 'https://www.ohsho.co.jp/menu/';

  // Uri _pendingLoadUri;

  @override
  Widget build(BuildContext context, watch) => Scaffold(
        body:
            //
            watch(pdfProvider('https://www.ohsho.co.jp/menu/pdf/allergy.pdf')).maybeWhen(
          data: (document) => PDFViewer(document: document),
          orElse: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
  // Timer _timer;

  // Future<NavigationDecision> onNavigationDelegate(NavigationRequest request) async {
  //   //
  //   //
  //   print('DEBUG: onNavigationDelegate $request');

  //   // return NavigationDecision.prevent;
  //   try {
  //     final originalUri = Uri.parse(request.url);
  //     final ext = path.extension(originalUri.path);

  //     print('DEBUG: $originalUri ext: $ext');

  //     if (ext == '.pdf' && Platform.isAndroid) {
  //       print('DEBUG: isPDF and isAndroid');

  //       //
  //       _pendingLoadUri = Uri.https(
  //         'docs.google.com',
  //         '/viewer',
  //         {
  //           'url': originalUri.toString(),
  //         },
  //       );

  //       // _timer?.cancel();
  //       // _timer = Timer(Duration(milliseconds: 300), onTimer);
  //       print('DEBUG: loadUrl ${_pendingLoadUri.toString()}');
  //       await _webViewController?.loadUrl('https://google.com/' /* _pendingLoadUri.toString() */);
  //       return NavigationDecision.prevent;
  //     }
  //   } catch (error) {
  //     //
  //     print('parse error: $error');
  //   }

  //   return NavigationDecision.navigate;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       Expanded(
  //         flex: 1,
  //         child: WebView(
  //           initialUrl: WebViewPage._initialUrl,
  //           javascriptMode: JavascriptMode.unrestricted,
  //           onWebViewCreated: (WebViewController webViewController) => _webViewController = webViewController,
  //           onPageStarted: (_) => print('DEBUG: onPageStarted'),
  //           // onPageFinished: (_) => print('DEBUG: onPageFinished'), //onPageFinished,
  //           navigationDelegate: onNavigationDelegate,
  //         ),
  //       ),
  //       Container(
  //         color: Colors.white,
  //         height: 20,
  //         //省略
  //       ),
  //     ],
  //   );
  // }
}
