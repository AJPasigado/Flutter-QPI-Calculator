import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Calculator',
    home: Calculator(),
  ));
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Column _buildNormalButton (String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(1, 0, 0, 0),
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNormalButton("0"),
          _buildNormalButton("."),
          _buildNormalButton("="),
        ],
      ),
    );

    return MaterialApp(
      title: 'Flutter QPI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter QPI'),
        ),
        body: ListView(
          children: [
            buttonSection,
          ],
        ),
      ),
    );
  }
}
