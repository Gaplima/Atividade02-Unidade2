import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Contador'),
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
  int _counter = 0;
  Timer? _holdTimer;
  bool pressMinus = false;
  bool pressPlus = false;
  bool pressTurbo = false;
  bool pressReset = false;

  Color bgColor = Colors.amber;

  void _changeBackgroundColor() {
    setState(() {
      bgColor =
          (bgColor == Colors.amber) ? Colors.deepOrangeAccent : Colors.amber;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    }); 
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0){
        _counter--;
      }
    }); 
  }

  void _startAutoIncrement() {
    _holdTimer?.cancel();
    _holdTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    _incrementCounter();
    });
  }
  void _startAutoDecrement() {
    _holdTimer?.cancel();
    _holdTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    _decrementCounter();
    });
  }
  void _startTurboIncrement() {
    _holdTimer?.cancel();
    _holdTimer = Timer.periodic(const Duration(milliseconds: 2), (timer) {
    _incrementCounter();
    });
  }
  void _stopAuto() {
    _holdTimer?.cancel();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('O valor do contador é:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onLongPressStart: (_) {
              _startAutoIncrement();
              setState(() => pressPlus = true); },
            onLongPressEnd: (_) {
              _stopAuto();
              setState(() => pressPlus = false); },
            onTapUp: (_) {
              _stopAuto();
              setState(() => pressPlus = true); },
            onTapCancel: () {
              _stopAuto();
              setState(() => pressPlus = false); },
            child: FloatingActionButton(
              heroTag: 'incrementHold',
              tooltip: 'Incrementar (segure)',
              backgroundColor:
                          pressPlus ? Colors.grey.shade300 : Colors.blue,
              onPressed: _incrementCounter,
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onLongPressStart: (_) {
              _startAutoDecrement();
              setState(() => pressMinus = true); },
            onLongPressEnd: (_) {
              _stopAuto();
              setState(() => pressMinus = false); },
            onTapUp: (_) {
              _stopAuto();
              setState(() => pressMinus = true); },
            onTapCancel: () {
              _stopAuto();
              setState(() => pressMinus = false); },
            child: FloatingActionButton(
              heroTag: 'decrementHold',
              tooltip: 'Diminuir (segure)',
              backgroundColor:
                          pressMinus ? Colors.grey.shade300 : Colors.blue,
              onPressed: _decrementCounter,
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onLongPressStart: (_) {
              _startTurboIncrement();
              setState(() => pressTurbo = true); },
            onLongPressEnd: (_) {
              _stopAuto();
              setState(() => pressTurbo = false); },
            onTapUp: (_) {
              _stopAuto();
              setState(() => pressTurbo = true); },
            onTapCancel: () {
              _stopAuto();
              setState(() => pressTurbo = false); },
            child: FloatingActionButton(
              heroTag: 'incrementTurbo',
              tooltip: 'Turbo (segure)',
              backgroundColor:
                          pressTurbo ? Colors.grey.shade300 : Colors.blue,
              onPressed: _incrementCounter,
              child: const Icon(Icons.speed),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: _resetCounter,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.restart_alt),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'changeBg',
            onPressed: _changeBackgroundColor,
            backgroundColor: Colors.blue,
            tooltip: 'Mudar fundo',
            child: const Icon(Icons.color_lens),
          )
        ],
      ),
    );
  }
}
