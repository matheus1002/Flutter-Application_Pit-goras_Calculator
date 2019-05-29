import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController partial1Controller = TextEditingController();
  TextEditingController official1Controller = TextEditingController();
  TextEditingController partial2Controller = TextEditingController();
  TextEditingController official2Controller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe as notas!";

  void _resetFields() {
    partial1Controller.text = "";
    official1Controller.text = "";
    partial2Controller.text = "";
    official2Controller.text = "";
    setState(() {
      _infoText = "Informe as notas!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double partial1 = double.parse(partial1Controller.text);
      double official1 = double.parse(official1Controller.text);
      double partial2 = double.parse(partial2Controller.text);
      double official2 = double.parse(official2Controller.text);
      double average = (((partial1 * 0.4) + (official1 * 0.6)) * 0.4) +
          (((partial2 * 0.4) + (official2 * 0.6)) * 0.6);

      if (partial1 <= 10.0 &&
          official1 <= 10.0 &&
          partial2 <= 10.0 &&
          official2 <= 10.0) {
        if (average >= 7.0 && average <= 10.0) {
          _infoText = "Aprovado: ${average.toStringAsPrecision(3)}";
        } else if (average >= 4.0 && average < 7.0) {
          _infoText = "De Final: ${average.toStringAsPrecision(3)}";
        } else if (average < 4.0) {
          _infoText = "Reprovado: ${average.toStringAsPrecision(3)}";
        }
      } else {
        _infoText = "Informe notas válidas!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simulador de Notas Pitágoras"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.class_,
                  size: 100.0, color: Colors.deepOrangeAccent[200]),
              buildTextFormField("Parcial 1", partial1Controller),
              Divider(),
              buildTextFormField("Oficial 1", official1Controller),
              Divider(),
              buildTextFormField("Parcial 2", partial2Controller),
              Divider(),
              buildTextFormField("Oficial 2", official2Controller),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.deepOrangeAccent[200],
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepOrangeAccent[200], fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextFormField(String label, TextEditingController c) {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepOrangeAccent[200])),
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 20.0),
    controller: c,
    validator: (value) {
      if (value.isEmpty) {
        return "Insira a nota!";
      }
    },
  );
}
