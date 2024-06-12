import 'package:flutter/material.dart';
import 'dart:math';

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
      home: const NumberGuessGame(),
    );
  }
}

class NumberGuessGame extends StatefulWidget {
  const NumberGuessGame({super.key});

  @override
  State<NumberGuessGame> createState() => _NumberGuessGameState();
}

class _NumberGuessGameState extends State<NumberGuessGame> {
  // nextIntは0~99までなので+1する
  int _numberToGuess = Random().nextInt(100) + 1;
  String _message = '私が思い浮かべている数字は何でしょうか？(1~100)';
  final TextEditingController _controller = TextEditingController();
  int _count = 0;

  void _guessNumber() {
    int? userGuess = int.tryParse(_controller.text);

    if (userGuess == null || userGuess <= 0 || userGuess > 100) {
      _message = '1から100の数値を入れてください';
      setState(() {
        _controller.clear();
      });
      return;
    } else if (userGuess == _numberToGuess) {
      _count++;
      _message =
          'おめでとうございます！「$userGuess」で正解です!\n$_count回目で当てました。\n新しい数字を思い浮かべます。';
      _numberToGuess = Random().nextInt(100) + 1;
      _count = 0;
    } else if (userGuess > _numberToGuess) {
      _count++;
      _message = '「$userGuess」は大きすぎます!もう一度試してみてください。';
    } else if (userGuess < _numberToGuess) {
      _count++;
      _message = '「$userGuess」は小さすぎます!もう一度試してみてください。';
    }

    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('数字当てゲーム')),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              // 中央揃え
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_message, style: TextStyle(fontSize: 24)),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'あなたの予想を入力してください。',
                  ),
                ),
                ElevatedButton(onPressed: _guessNumber, child: Text('予想を回答する'))
              ])),
    );
  }
}
