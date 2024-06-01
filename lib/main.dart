import 'package:flutter/material.dart';

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
  void _pushPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NextPage(id: 1, name: 'プッシュ呼び出し');
    }));
  }

  void _modalPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return NextPage(id: 2, name: 'モーダル呼び出し');
          },
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _pushPage();
                  },
                  child: const Text('プッシュ遷移')),
              ElevatedButton(
                  onPressed: () {
                    _modalPage();
                  },
                  child: const Text('モーダル遷移')),
            ],
          ),
        ));
    ;
  }
}

class NextPage extends StatelessWidget {
  // construct
  NextPage({required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next Pageです。id = [$id] name = [$name]',
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(id == 1 ? '戻る' : '閉じる'),
            ),
          ],
        ),
      ),
    );
  }
}
