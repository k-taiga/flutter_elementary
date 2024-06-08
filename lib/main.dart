import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

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
      home: const StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Timer _timer = Timer(Duration.zero, () {});
  // Flutterが定義しているStopwatchオブジェクト
  final Stopwatch _stopwatch = Stopwatch();
  String _time = '00:00:000';

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      // 1millisecondごとに実施する処理
      _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        // setStateを呼び出すことで画面を再描画
        setState(() {
          // Stopwatch.elapsedは経過時間を返す
          final Duration elapsed = _stopwatch.elapsed;
          // 0付きの2桁の文字列に変換
          final String minute = elapsed.inMinutes.toString().padLeft(2, '0');
          final String sec =
              (elapsed.inSeconds % 60).toString().padLeft(2, '0');
          final String milliSec =
              (elapsed.inMilliseconds % 1000).toString().padLeft(3, '0');
          _time = '$minute:$sec:$milliSec';
        });
      });
    }
  }

  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    // 初期値で画面を再描画
    setState(() {
      _time = "00:00:000";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ストップウォッチ')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('経過時間'),
              const SizedBox(height: 10),
              Text('$_time', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _startTimer();
                      },
                      child: const Text('スタート')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        _stopTimer();
                      },
                      child: const Text('ストップ')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        _resetTimer();
                      },
                      child: const Text('リセット')),
                ],
              )
            ],
          ),
        ));
  }
}
