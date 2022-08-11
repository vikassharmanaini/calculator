import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  final List<String> button = ['A/C','+/-','%','DEL','7','8','9','/','4','5','6','*','1','2','3', '-','0','.','=','+',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      backgroundColor: Colors.white60,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white30,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: button[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonText: button[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 2) {
                      return MyButton(
                        buttonText: button[index],
                        buttontapped: () {
                          setState(() {
                            userInput += button[index];
                          });
                        },
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 18) {
                      return MyButton(
                        buttonText: button[index],
                        buttontapped: () {
                          setState(() {
                            equalPassed();
                          });
                        },
                        color: Colors.orange[700],
                        textColor: Colors.white30,
                      );
                    } else {
                      return MyButton(
                        buttonText: button[index],
                        buttontapped: () {
                          setState(() {
                            userInput += button[index];
                          });
                        },
                        color: isOperator(button[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(button[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPassed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();

    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
