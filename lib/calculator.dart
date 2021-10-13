
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression= '0';
  String history = '0';

  //to clear the expression history
  void clear(String text)
  {
    setState(() {
      expression = '0';
      history = '0';
    });
  }

  void backSpace()
  {
    if(expression != '0' || expression != '00')
      {
        setState(() {
          expression = expression.substring(expression.length -1);
          print(expression);
        });
      }
  }

  void numClick(String text)
  {
    setState(() {

      //remove extra arithmetic operator
      if(text == '%' || text == '/' || text == '*' || text == '+' || text == '-')
        {
          String newString = expression.substring(expression.length -1);
          if(newString == '%' || newString == '/' || newString == '*' || newString == '+' || newString == '-')
            {
              text = '';
            }
        }
      
      //check if the . button press
      if(text == '.')
      {
        //to check if the . already exist in expression
        if(expression.contains('.')){
          text = '';
        }
        //to allow leading zero with decimal point
        if(expression == '0')
          {
            text = '0' + text;
          }
      }

      if(expression == '0' || expression == '00')
        {
          expression = '';
          if(text == '%' || text == '/' || text == '*' || text == '+' || text == '-')
            {
              text = '0' + text;
            }
        }



      expression  = expression + text;
    });
  }

  void calculate(String text)
  {
    var p = Parser();
    Expression ex = p.parse(expression);
    ContextModel cm = ContextModel();
    double result = ex.evaluate(EvaluationType.REAL, cm);
    setState(() {
      history = expression;
      expression = result.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15.0),
              alignment: Alignment.centerRight,
                child: Text('$expression', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ),)),
            Container(
                margin: EdgeInsets.only(bottom: 15.0),
                alignment: Alignment.centerRight,
                child: Text('$history', style: TextStyle(fontSize: 22),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                calcButton(buttonText: 'C', callBack: clear),
                calcButton(buttonText: '%', callBack: numClick),
                calcButton(callBack: backSpace),
                calcButton(buttonText: '/', callBack: numClick),
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                calcButton(buttonText: '7', callBack: numClick),
                calcButton(buttonText: '8', callBack: numClick),
                calcButton(buttonText: '9', callBack: numClick),
                calcButton(buttonText: '*', callBack: numClick),
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                calcButton(buttonText: '4', callBack: numClick),
                calcButton(buttonText: '5', callBack: numClick),
                calcButton(buttonText: '6', callBack: numClick),
                calcButton(buttonText: '-', callBack: numClick),
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                calcButton(buttonText: '1', callBack: numClick),
                calcButton(buttonText: '2', callBack: numClick),
                calcButton(buttonText: '3', callBack: numClick),
                calcButton(buttonText: '+', callBack: numClick),
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                calcButton(buttonText: '00', callBack: numClick),
                calcButton(buttonText: '0', callBack: numClick),
                calcButton(buttonText: '.', callBack: numClick),
                calcButton(buttonText: '=', callBack: calculate),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget calcButton({String? buttonText, Function? callBack})
  {
    Widget buttonWidget = Icon(Icons.backspace_outlined, size: 25,);
    if(buttonText != null)
      {
        buttonWidget = Text('$buttonText', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),);
      }
    return IconButton(
      onPressed: ()
      {
        callBack!(buttonText);
      }
      ,
      icon: buttonWidget,
      splashColor: Colors.grey,
      focusColor: Colors.black,
    );
  }
}
