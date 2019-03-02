import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Color.fromARGB(200, 109, 180, 194),
    ));

    double returnQPI(List<String> grades) {
      double cumulative = 0;
      grades.forEach((i) => cumulative += gradeDict[i]);
      return (cumulative / grades.length);
    }

    RawMaterialButton grade_button(String text) {
      return RawMaterialButton(
        shape: new CircleBorder(),
        padding: EdgeInsets.all(45),
        child: Text(
          text,
          style: new TextStyle(fontSize: 20, color: Colors.white),
        ),
        elevation: 0,
        splashColor: Colors.blueGrey[100],
        onPressed: () {
          buffer.add(text);
          txt_controller_equation.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: buffer.length == 1
                          ? text
                          : txt_controller_equation.value.text + ",  " + text))
              .value;
          if (buffer.length == 1) {
            txt_controller_result.value = new TextEditingValue();
          }
          print(buffer);
        },
      );
    }

    RawMaterialButton _buildNormalButton(String label) {
      return RawMaterialButton(
        shape: new CircleBorder(),
        padding: EdgeInsets.all(45),
        child: Text(
          label,
          style: new TextStyle(fontSize: 20, color: Colors.white),
        ),
        elevation: 0,
        splashColor: Colors.blueGrey[100],
        onPressed: () {
          buffer.clear();
          txt_controller_equation.value = new TextEditingValue();
          txt_controller_result.value = new TextEditingValue();
        },
      );
    }

    RawMaterialButton equal_button() {
      return RawMaterialButton(
        shape: new CircleBorder(),
        padding: EdgeInsets.all(45),
        fillColor: Color.fromARGB(200, 109, 151, 234),
        child: Text(
          "=",
          style: new TextStyle(fontSize: 20, color: Colors.white),
        ),
        elevation: 4,
        splashColor: Colors.blueGrey[100],
        onPressed: () {
          var qpi = returnQPI(buffer);
          print(qpi);
          buffer.clear();
          txt_controller_result
            ..value = new TextEditingController.fromValue(
                    new TextEditingValue(text: qpi.toStringAsFixed(2)))
                .value;
        },
      );
    }

    Row _buildButtonRow(btn1, btn2, btn3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btn1,
          btn2,
          btn3,
        ],
      );
    }

    return MaterialApp(
      title: 'Flutter QPI',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1],
              colors: [
                Color.fromARGB(200, 109, 180, 194),
                Color.fromARGB(200, 109, 151, 234),
              ],
            ),
          ),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 190,
                      width: 380,
                      child: new TextField(
                        keyboardType: TextInputType.multiline,
                        decoration:
                            new InputDecoration(border: InputBorder.none, isDense: false, enabled: false),
                        textAlign: TextAlign.right,
                        enabled: false,
                        maxLines: null,
                        controller: txt_controller_equation,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 380,
                      child: new TextField(
                        decoration: new InputDecoration(
                            hintText:
                                "Start adding grades by tapping the buttons",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.white70)),
                        textAlign: TextAlign.right,
                        enabled: false,
                        controller: txt_controller_result,
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    _buildButtonRow(grade_button("A"), grade_button("B+"),
                        grade_button("B")),
                    _buildButtonRow(grade_button("C+"), grade_button("C"),
                        grade_button("D")),
                    _buildButtonRow(grade_button("F/FD"),
                        _buildNormalButton("clr"), equal_button()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
