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
  var answer = '0';
  validate_del() {
    if (userInput.length > 1) {
      return userInput.substring(0, userInput.length - 1);
    } else {
      return '';
    }
  }

  final List<String> button = [
    'A/C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  clipBehavior: Clip.hardEdge,
                  itemCount: button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 3.0),
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
                        color: Color.fromARGB(26, 0, 140, 255),
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
                    } else if (index == 3) {
                      return MyButton(
                        buttonText: button[index],
                        buttontapped: () {
                          setState(() {
                            userInput = validate_del();
                          });
                        },
                        textColor: Colors.black,
                        color: Colors.blue[50],
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
                        textColor: Colors.black,
                      );
                    } else {
                      return MyButton(
                        buttonText: button[index],
                        buttontapped: () {
                          setState(() {
                            isOperator(button[index])
                                ? userInput += button[index]
                                : validateuserinput()
                                    ? userInput = button[index]
                                    : userInput += button[index];
                          });
                        },
                        color: isOperator(button[index])
                            ? Color(0x21008CFF)
                            : Color.fromARGB(255, 164, 164, 164),
                        textColor: isOperator(button[index])
                            ? Colors.black
                            : Colors.white,
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  validateuserinput() {
    if (userInput == '') {
      return true;
    }
    return false;
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
