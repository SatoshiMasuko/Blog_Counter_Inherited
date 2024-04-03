import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class _InheritedCounter extends InheritedWidget {
  const _InheritedCounter({
    required this.data,
    required super.child,
  });

  final MyCounterState data;

  @override
  bool updateShouldNotify(_InheritedCounter oldWidget) => true;
}

class MyCounter extends StatefulWidget {
  const MyCounter({
    super.key,
    required this.child,
  });

  final Widget child;

  static MyCounterState of(BuildContext context, {bool rebuild = true}) {
    return rebuild
        ? context.dependOnInheritedWidgetOfExactType<_InheritedCounter>()!.data
        : (context
        .getElementForInheritedWidgetOfExactType<_InheritedCounter>()!
        .widget as _InheritedCounter)
        .data;
  }

  @override
  State<MyCounter> createState() => MyCounterState();
}

class MyCounterState extends State<MyCounter> {
  int count = 0;

  void increment() => setState(() {
    count++;
  });

  @override
  Widget build(BuildContext context) {
    return _InheritedCounter(
      data: this,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyCounter(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ボタンを押した回数',
                ),
                Builder(
                  builder: (context) {
                    return Text(
                      '${MyCounter.of(context).count}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyCounter.of(context, rebuild: false).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}