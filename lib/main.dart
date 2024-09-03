import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator ProdigyInforTech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String output = "0";
  String input = "";
  String _output = "0";
  List<String> _operations = [];
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      resetCalculator();
    } else if (buttonText == "DEL") {
      deleteLastCharacter();
    } else if (isOperator(buttonText)) {
      addOperator(buttonText);
    } else if (buttonText == "=") {
      calculateResult();
    } else {
      addDigit(buttonText);
    }

    setState(() {
      output = _output;
    });
  }

  void resetCalculator() {
    _output = "0";
    input = "";
    _operations.clear();
  }

  void deleteLastCharacter() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
      _output = _output.isNotEmpty ? _output.substring(0, _output.length - 1) : "0";
    }
  }

  bool isOperator(String text) {
    return text == "+" || text == "-" || text == "/" || text == "*";
  }

  void addOperator(String operator) {
    _operations.add(_output);
    _operations.add(operator);
    operand = operator;
    input += " $operator ";
    _output = "0";
  }

  void addDigit(String digit) {
    if (_output == "0" && digit != ".") {
      _output = digit;
    } else {
      _output += digit;
    }
    input += digit;
  }

  void calculateResult() {
    _operations.add(_output);
    try {
      double result = double.parse(_operations[0]);

      for (int i = 1; i < _operations.length; i += 2) {
        String operation = _operations[i];
        double nextNumber = double.parse(_operations[i + 1]);

        switch (operation) {
          case "+":
            result += nextNumber;
            break;
          case "-":
            result -= nextNumber;
            break;
          case "*":
            result *= nextNumber;
            break;
          case "/":
            if (nextNumber != 0) {
              result /= nextNumber;
            } else {
              throw Exception("Division by zero");
            }
            break;
        }
      }

      _output = result.toString();
    } catch (e) {
      _output = "Error";
    }
    input += " = $_output";
    _operations.clear();
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: OutlinedButton(
          onPressed: () => buttonPressed(buttonText),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: Text(
              buttonText,
              key: ValueKey<String>(buttonText),
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            shape: const RoundedRectangleBorder(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator ProdigyInforTech'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                input,
                key: ValueKey<String>(input),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                output,
                key: ValueKey<String>(output),
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("C"),
                  buildButton("DEL"),
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
