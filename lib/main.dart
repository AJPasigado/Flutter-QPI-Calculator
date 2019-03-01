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
  @override
  Widget build(BuildContext context) {
    Column _buildNormalButton(String label) {
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
    //var txt_controller_equation = new TextEditingController();
    final txt_controller_equation = TextEditingController();
    final txt_controller_result = TextEditingController();

    double returnQPI(List<String> grades) {
      double cumulative = 0;
      grades.forEach((i) => cumulative += gradeDict[i]);
      return (cumulative / grades.length);
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

    GestureDetector grade_button(String text) {
      return GestureDetector(
        onTap: () {
          buffer.add(text);
          txt_controller_equation.value = new TextEditingController.fromValue(
                  new TextEditingValue(text: txt_controller_equation.value.text +" . "+ text)).value;
          //txt_controller_equation.text="AAA";
          //_equationText();
          print(buffer);
          //new RaisedButton(onPressed: () {
          //  setState(() {txt_controller_equation.text = "My Stringt";});
          //  }
          // );
        },
        child: 
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(100, 0, 0, 0),
              ),
              ),
          ),

        
        /*Text(
          text,
          style: TextStyle(fontSize: 32.0, color: Colors.black),
        ),*/
      );
    }

    GestureDetector equal_button() {
      return GestureDetector(
        onTap: () {
          var qpi = returnQPI(buffer);
          print(qpi);
          buffer.clear();
          txt_controller_equation.value = new TextEditingController.fromValue(
                  new TextEditingValue(text: '')).value;
          txt_controller_result..value = new TextEditingController.fromValue(
                  new TextEditingValue(text: qpi.toString())).value;
        },
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Text(
              "=",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(100, 0, 0, 0),
              ),
              ),
          ),
      );
    }

    return MaterialApp(
      title: 'Flutter QPI',
      home: Scaffold(
        body: ListView(
          children: [
            Container(height:100, padding:EdgeInsets.all(20),

              child: Row(
                children: <Widget>[
                  new Text(
                    "Equation",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ),
                  Container(width: 260 ,child:new TextField(
                    controller: txt_controller_equation,
                    //style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),)
                  
                ],
              ),
            ),
            Container(padding:EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Text(
                    "Result",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ),
                  Container(width: 260 ,child:new TextField(
                    controller: txt_controller_result
                    //style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),
                ),
                ],
              ),
            ),
            // THis is the spacing between the buttonsand the display.
            Container(height:130), 
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
