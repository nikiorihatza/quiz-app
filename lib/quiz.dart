import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
}) : super (key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          widget.questions[widget.questionIndex]['questionText'].toString(),
        ), //Question
        ...(widget.questions[widget.questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
                  () => widget.answerQuestion(answer['score']), answer['text'].toString());
        }).toList()
      ],
    ); //Column
  }
}