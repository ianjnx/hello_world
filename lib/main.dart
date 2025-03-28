import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create Hello World',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark, 
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;
  int _colorIndex = 0;

  final List<Color> _colors = <Color>[
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  final List<String> _greetings = <String>[
    'Hello, World!',
    '¡Hola, Mundo!',
    'Bonjour, Monde!',
    'Ciao, Mondo!',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _changeGreeting() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _greetings.length;
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _colors[_colorIndex].withOpacity(0.8),
              _colors[_colorIndex].withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated rotating icon
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
                child: Icon(
                  Icons.flutter_dash,
                  size: 100,
                  color: _colors[_colorIndex],
                ),
              ),
              const SizedBox(height: 40),
              // Animated greeting text
              GestureDetector(
                onTap: _changeGreeting,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(_isExpanded ? 30.0 : 20.0),
                  decoration: BoxDecoration(
                    color: _colors[_colorIndex].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                      _isExpanded ? 50.0 : 25.0,
                    ),
                    border: Border.all(color: _colors[_colorIndex], width: 2),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 500),
                    style: TextStyle(
                      fontSize: _isExpanded ? 32.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: Text(_greetings[_colorIndex]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tap the greeting to change languages!',
                style: TextStyle(color: _colors[_colorIndex].withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeGreeting,
        backgroundColor: _colors[_colorIndex],
        child: const Icon(Icons.refresh),
      ),
    );
  }
}