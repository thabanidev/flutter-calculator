import 'package:flutter/material.dart';
import 'package:eval_ex/expression.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: const Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = '0';

  buildBtn(String btnText, double btnHeight, Color btnColor, {bool isCAOrC = false}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      // Clear & Equal button must be twice as long as the others
      width: isCAOrC ? MediaQuery.of(context).size.width * 0.75 : MediaQuery.of(context).size.width * 0.25,
      color: btnColor,
      child: TextButton(
        onPressed: () => handleBtnClick(btnText),
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String calculateResult() {
    // Replace all '×' and '÷' with '*' and '/'
    String expression = result;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    // Calculate the result
    Expression exp = Expression(expression);
    String res = exp.eval().toString();

    return res;
  }

  handleBtnClick(String btnText) {
    if (btnText == 'CLEAR') {
      setState(() {
        result = '0';
      });
    } else if (btnText == '⌫') {
      setState(() {
        result = result.substring(0, result.length - 1);
      });
    } else if (btnText == '=') {
      setState(() {
        result = calculateResult();
      });
    } else {
      setState(() {
        if (result == '0') {
          result = btnText;
        } else {
          result += btnText;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.bottomRight,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: [
            // First button must be twice as long as the others
            buildBtn('CLEAR', 1, Colors.redAccent, isCAOrC: true),
            buildBtn('÷', 1, Colors.blue),
          ],
        ),
        Row(
          children: [
            buildBtn('7', 1, Colors.black54),
            buildBtn('8', 1, Colors.black54),
            buildBtn('9', 1, Colors.black54),
            
            buildBtn('×', 1, Colors.blue),
          ],
        ),
        Row(
          children: [
            buildBtn('4', 1, Colors.black54),
            buildBtn('5', 1, Colors.black54),
            buildBtn('6', 1, Colors.black54),
            
            buildBtn('-', 1, Colors.blue),
          ],
        ),
        Row(
          children: [
            buildBtn('1', 1, Colors.black54),
            buildBtn('2', 1, Colors.black54),
            buildBtn('3', 1, Colors.black54),
            buildBtn('+', 1, Colors.blue),
            
          ],
        ),
        Row(
          children: [
            buildBtn('.', 1, Colors.black54),
            buildBtn('0', 1, Colors.black54),
            buildBtn('⌫', 1, Colors.black54),
            
            buildBtn('=', 1, Colors.green),
          ],
        ),
      ],
    );
  }
}