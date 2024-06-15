import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  TextEditingController controller = TextEditingController();
  List<String> items = [];
  String errorMessage = '';

  // 非同期関数 Future<返り値> 関数 async
  Future<void> loadZipCode(String zipCode) async {
    setState(() {
      errorMessage = 'APIレスポンス待ち';
    });

    final response = await http.get(
        Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode'));

    if (response.statusCode != 200) {
      return;
    }

    // json decodeした結果をasでMap型にキャスト KeyがString,Valueがdynamic(何でもOKな型)
    final body = json.decode(response.body) as Map<String, dynamic>;
    // resultsが存在しなければ [] を入れてからasでキャスト
    final results = (body['results'] ?? []) as List<dynamic>;

    if (results.isEmpty) {
      setState(() {
        errorMessage = 'そのような郵便番号の住所はありません';
      });
    } else {
      setState(() {
        errorMessage = '';
        // mapでresultsの各要素を回して新しいコレクションを生成
        // toList(growable:false)で生成したコレクションをListに変更しその値の変更ができないようにする
        items = results
            .map((result) =>
                "${result['address1']}${result['address2']}${result['address3']}")
            .toList(growable: false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    loadZipCode(value);
                  }
                })),
        body: ListView.builder(
          // BuildContextとindexを引数に取り、Widgetを返す関数
          // indexはリストのインデックス
          itemBuilder: (context, index) {
            if (errorMessage.isNotEmpty) {
              return ListTile(title: Text(errorMessage));
            } else {
              return ListTile(title: Text(items[index]));
            }
          },
          itemCount: items.length,
        ));
  }
}
