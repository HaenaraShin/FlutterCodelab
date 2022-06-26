import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
          ),
          body: RandomWords()
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({ Key? key }) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // // var : 값이 변할 수 있는 변수
  // // final : 한번 선언하면 값이 변할 수 없는 상수
  // var wordPair = WordPair.random(); // Add this line.
  final _suggestions = <WordPair>[];                 // NEW
  final _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  Widget build(BuildContext context) {
    // return Center(
    //     child: ColoredBox(
    //         color: Colors.cyan,
    //         child: Padding(
    //             padding: const EdgeInsets.all(8),
    //             child: TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   wordPair = WordPair.random();
    //                   print(wordPair);
    //                 });
    //               },
    //               child: Text(wordPair.asPascalCase), // With this text.
    //             )
    //         )
    //     )
    // );
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        // 나눗셈에서 몫을 뽑아내는 것
        final index = i ~/ 2;

        // 지정된 영역을 넘어서면 10개 데이터를 추가 시킨다.
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}
