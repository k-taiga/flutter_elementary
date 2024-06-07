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
      home: const MyCheckBox(),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isChecked = false;

  void _toggleCheckbox() {
    // setStateで状態を更新
    setState(() {
      isChecked = !isChecked;
    });
    print('_toggleCheckbox isChecked=[$isChecked]');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyCheckBox Demo'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: CheckboxListTile(
                  // CheckBoxを左寄せする
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('利用規約に同意する。'),
                  value: isChecked,
                  onChanged: (value) {
                    _toggleCheckbox();
                  }),
            ),
            Text('isChecked = [$isChecked]')
          ]),
        ));
  }
}
