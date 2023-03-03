import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos_4ahif_quis/question.dart';
import 'package:pos_4ahif_quis/quiz.dart';
import 'package:pos_4ahif_quis/results.dart';
import 'package:responsive_framework/responsive_framework.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();
const SnackBar snackBar = SnackBar(content: Text('Developed by Nikola Stanic'));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUIZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QUIZ'),
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
  final _questions = const [
    {
      'questionText': 'Frage 1: Welches Unternehmen hat einen Apfel als Logo?',
      'answers': [
        {'text': 'Google', 'score': -1},
        {'text': 'Samsung', 'score': -1},
        {'text': 'Apple', 'score': 1},
        {'text': 'Microsoft', 'score': -1},
      ],
    },
    {
      'questionText': 'Frage 2: Was ist das bekannteste Java-Game?',
      'answers': [
        {'text': 'Call of Duty', 'score': -1},
        {'text': 'Pokemon', 'score': -1},
        {'text': 'Dead by Daylight', 'score': -1},
        {'text': 'Minecraft', 'score': 1},
      ],
    },
    {
      'questionText': 'Frage 3: Wie heißt der neueste Apple-Chip?',
      'answers': [
        {'text': 'M1', 'score': -1},
        {'text': 'M2', 'score': 1},
        {'text': 'i7-5600U', 'score': -1},
        {'text': 'Ryzen 5 3600', 'score': -1},
      ],
    },
    {
      'questionText': 'Frage 4: Wie hieß der CEO und Gründer von Apple?',
      'answers': [
        {'text': 'Steve Jobs', 'score': 1},
        {'text': 'Elon Musk', 'score': -1},
        {'text': 'Bill Gates', 'score': -1},
        {'text': 'Donald Trump', 'score': -1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('Es gibt mehr Fragen!');
    } else {
      // ignore: avoid_print
      print('Keine Fragen mehr!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ScaffoldMessenger(
          key: scaffoldKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Quiz'),
              backgroundColor: const Color.fromRGBO(15, 98, 146, 1),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.showSnackBar(snackBar);
                    },
                    icon: const Icon(Icons.code),
                    tooltip: 'Show Snackbar'),
                IconButton(
                    tooltip: 'close',
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white
                ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 120
                  )
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 250.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Willkommen beim Quiz!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromRGBO(15, 98, 146, 1),
                                Color.fromRGBO(1, 45, 71, 1)
                              ],
                            ),
                          ),
                        )),
                        TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {
                              if (kDebugMode) {
                                print('Start-Button pressed');
                              }
                              _questionIndex < _questions.length
                                  ? setState(() {
                                Quiz(
                                  answerQuestion: _answerQuestion,
                                  questionIndex: _questionIndex,
                                  questions: _questions
                                );
                                }) : Result(_totalScore, _resetQuiz);
                            },
                            child: const Text('Starte das Quiz'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}