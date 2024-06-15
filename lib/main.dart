import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<String>> items = [
    ['Flutter', 'https://flutter.dev/'],
    ['Google', 'https://www.google.co.jp/'],
    ['YouTube', 'https://www.youtube.com/'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ブックマーク')),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final item = items[index];
            final title = item[0] ?? '';
            final url = item[1] ?? '';
            return ListTile(
                title: Text(title),
                // onTapでWebViewPageに遷移
                onTap: () {
                  // contextとMaterialPageRouteを引数に渡す
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WebViewPage(title: title, url: url);
                  }));
                });
          },
          itemCount: items.length,
        ));
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({required this.title, required this.url, super.key});
  final String title;
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // lateで宣言すると、初期化を遅らせることができる
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // ここでWebViewControllerを初期化
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
