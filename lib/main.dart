import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //variables
  String userInput = '';
  String result = '';

  //custom Widget for the button
  Widget calculatorButton(
      String buttonText, Color buttonColor, Color textColor) {
    return InkWell(
        splashColor: buttonColor,
        onTap: () {
          //FUNCTION TO DEFINE :  BEHAVIOR WHEN THE BUTTON IS PRESSED
          setState(() {
            handleButton(buttonText);
          });
        },
        child: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF13161A).withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 0.3,
                    offset: Offset(3, 3))
              ]),
          child: Center(
            child:  Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: 45,
              ),
            ),
          )
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF575454),
      appBar: AppBar(
        title: Text(
          'CALCULATOR APP',
          style: TextStyle(
              fontSize: 30,
              color: Color(0xFFEFEFEF),
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF1E1C1C),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10,30,10,10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Calculator Display
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                child: Text(
                  userInput,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 65),
                ),
              ),
            ),
            Divider(
              indent: 10,
              thickness: 5,
            ),
            //Display  Buttons (Row 1)
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton('AC', Colors.black45, Color(0xFFE9FDF2)),
                calculatorButton('(', Colors.black45, Color(0xFFE9FDF2)),
                calculatorButton(')', Colors.black45, Color(0xFFE9FDF2)),
                calculatorButton('/', Color(0xFF1794AB), Color(0xFFE9FDF2)),
              ],
            ),
            //Display  Buttons (Row 2)
            Padding(padding: EdgeInsets.only(bottom: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton('7', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('8', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('9', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('*', Color(0xFF1794AB), Color(0xFFE9FDF2)),
              ],
            ),
            //Display  Buttons (Row 3)
            Padding(padding: EdgeInsets.only(bottom: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton('4', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('5', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('6', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('-', Color(0xFF1794AB), Color(0xFFE9FDF2)),
              ],
            ),
            //Display  Buttons (Row 4)
            Padding(padding: EdgeInsets.only(bottom: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton('1', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('2', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('3', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('+', Color(0xFF1794AB), Color(0xFFE9FDF2)),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 22)),
            //Display  Buttons (last Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton('C',Color(0xA08DD8EE), Colors.black),
                calculatorButton('0', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('.', Color(0xFFA3A9A9), Colors.black),
                calculatorButton('=', Color(0xFF1794AB), Color(0xFFE9FDF2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

//CALCULATOR LOGIC
  String? handleButton(String buttonText) {
    if (buttonText == 'AC') {
      userInput = '';
      result = '0';
      return result;
    }
    if (buttonText == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0,userInput.length - 1);
        return userInput;
      } else {
        return null;
      }
    }
    if (buttonText == '=') {
      result = calculate();
      userInput= result;

      if(userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', '');
      }
        if (result.endsWith('.0')) {
          result = result.replaceAll('.0', '');
          return result;
        }
      }
    userInput = userInput + buttonText;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'ERROR';
      
    }
  }
  }
