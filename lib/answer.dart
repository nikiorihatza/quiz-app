import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super (key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton (
        onPressed: selectHandler(),
        style: ButtonStyle(
          textStyle:
            MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(1, 45, 71, 1)),
        ), child: Text(answerText),
      )
    );
  }
}