import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Welcome to Flutter',
    //   home: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Welcome to Flutter'),
    //       ),
    //       body: RandomWords()),
    // );
    return MaterialApp(
      // MODIFY with const
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: RandomWords(), // REMOVE Scaffold
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // // var : 값이 변할 수 있는 변수
  // // final : 한번 선언하면 값이 변할 수 없는 상수
  // var wordPair = WordPair.random(); // Add this line.
  final _suggestions = <WordPair>[]; // NEW
  final _saved = <WordPair>{}; // NEW
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
    return Scaffold(
        // NEW from here ...
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
            ),
          ],
        ),
        body: ListView.builder(
          // to here.
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            // 나눗셈에서 몫을 뽑아내는 것
            final index = i ~/ 2;

            // 지정된 영역을 넘어서면 10개 데이터를 추가 시킨다.
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }

            final alreadySaved = _saved.contains(_suggestions[index]);

            return ListTile(
              title: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(_suggestions[index]);
                  } else {
                    _saved.add(_suggestions[index]);
                  }
                });
              },
            );
          },
        ));
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }
}
