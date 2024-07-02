import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WordSequence(),
    );
  }
}

class WordSequence extends StatefulWidget {
  const WordSequence({super.key});

  @override
  State<WordSequence> createState() => _WordSequenceState();
}

class _WordSequenceState extends State<WordSequence> {
  List<String> words = ['you', 'are', 'babo'];
  int _currentIndex = 0;

  void _showNextWord() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % words.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showNextWord,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            words[_currentIndex],
            style: const TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }
}