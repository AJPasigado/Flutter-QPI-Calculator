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
            margin: const EdgeInsets.only(top: 50),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(100, 0, 0, 0),
              ),
            ),
          ),
        ],
      );
    }

    Row _buildButtonRow (String btn1, String btn2, String btn3) {
      return Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNormalButton(btn1),
          _buildNormalButton(btn2),
          _buildNormalButton(btn3),
        ],
      );
    }

    Widget buttonSection = Container (
      child: Column(
        children: <Widget>[
          _buildButtonRow("A", "B+", "B"),
          _buildButtonRow("C+", "C", "D"),
          _buildButtonRow("F/FD", "clr", "=")
        ],
      ),
    );

    Text _resultText (String text){
      return Text (
        text,
        style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(100, 0, 0, 0),
              ),
      );
    }

    Text _equationText (String text){
      return Text (
        text,
        style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(100, 0, 0, 0),
              ),
      );
    }

    Widget resultSection = Container (
      child: Row(
        children: <Widget>[
          _resultText("Result"),
        ],
      ),
    );

    Widget equationSection = Container (
      child: Row(
        children: <Widget>[
          _equationText("Equation"),
        ],
      ),
    );

    return MaterialApp(
      title: 'Flutter QPI',
      home: Scaffold(
        body: ListView(
          children: [
            equationSection,
            resultSection,
            buttonSection,
          ],
        ),
      ),
    );
  }
}

