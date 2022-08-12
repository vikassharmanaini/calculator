import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;
  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.1),
      child: Center(
        child: GestureDetector(
          onTap: buttontapped,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: ClipRRect(
                child: Container(
              child: Center(
                  child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )),
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    color,
                    Color(0xFFFFFFFF),
                    color,
                  ]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ]),
            )),
          ),
        ),
      ),
    );
  }
}
