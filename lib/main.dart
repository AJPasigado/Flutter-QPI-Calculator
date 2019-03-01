import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Calculator',
    home: MainCalc(),
  ));
}

class MainCalc extends StatefulWidget {
  Calculator createState() => Calculator();
}

class Calculator extends State<MainCalc> {
  final txt_controller_equation = TextEditingController();
  final txt_controller_result = TextEditingController();

  List<String> buffer = [];

  final gradeDict = const {
    'A': 4,
    'B+': 3.5,
    'B': 3,
    'C+': 2.5,
    "C": 2,
    "D": 1,
    "F/FD": 0
  };

  @override
  Widget build(BuildContext context) {
    double returnQPI(List<String> grades) {
      double cumulative = 0;
      grades.forEach((i) => cumulative += gradeDict[i]);
      return (cumulative / grades.length);
    }

    RaisedButton grade_button(String text) {
      return RaisedButton(
        child: Text(text),
        color: Colors.white,
        elevation: 0,
        splashColor: Colors.blueGrey,
        onPressed: () {
          buffer.add(text);
          txt_controller_equation.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: txt_controller_equation.value.text + " " + text))
              .value;
          print(buffer);
        },
      );
    }

    RaisedButton _buildNormalButton(String label) {
      return RaisedButton(
        child: Text(label),
        color: Theme.of(context).accentColor,
        elevation: 0,
        splashColor: Colors.blueGrey,
        onPressed: () {
          buffer.clear();
          txt_controller_equation.value = new TextEditingValue();
          txt_controller_result.value = new TextEditingValue();
        },
      );
    }

    RaisedButton equal_button() {
      return RaisedButton(
        child: Text("="),
        color: Theme.of(context).accentColor,
        elevation: 0,
        splashColor: Colors.blueGrey,
        onPressed: () {
          var qpi = returnQPI(buffer);
          print(qpi);
          buffer.clear();
          txt_controller_equation.value = new TextEditingController.fromValue(
                  new TextEditingValue(text: ''))
              .value;
          txt_controller_result
            ..value = new TextEditingController.fromValue(
                    new TextEditingValue(text: qpi.toString()))
                .value;
        },
      );
    }

    Row _buildButtonRow(btn1, btn2, btn3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btn1,
          btn2,
          btn3,
        ],
      );
    }

    return MaterialApp(
      title: 'Flutter QPI',
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              height: 100,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 260,
                    child: new TextField(
                      controller: txt_controller_equation,
                      //style: TextStyle(fontSize: 32.0, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 260,
                    child: new TextField(controller: txt_controller_result
                        //style: TextStyle(fontSize: 32.0, color: Colors.black),
                        ),
                  ),
                ],
              ),
            ),
            // THis is the spacing between the buttonsand the display.
            Container(height: 130),
            Container(
              child: Column(
                children: <Widget>[
                  _buildButtonRow(
                      grade_button("A"), grade_button("B+"), grade_button("B")),
                  _buildButtonRow(
                      grade_button("C+"), grade_button("C"), grade_button("D")),
                  _buildButtonRow(grade_button("F/FD"),
                      _buildNormalButton("clr"), equal_button()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
