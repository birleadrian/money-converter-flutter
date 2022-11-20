import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sum = 0.0;
  String _convertFrom = "Convert from RON to EUR";
  final String _convertFromEur = "Convert from EUR to RON";
  final String _convertFromRon = "Convert from RON to EUR";
  String _currencyNo1 = "RON";
  String _currencyNo2 = "EUR";
  final myController = TextEditingController();
  final myControllerEur = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    myControllerEur.dispose();
    super.dispose();
  }

  void compute() {
    if (myController.text.isNotEmpty) {
      if (_currencyNo1 == "RON") {
        _sum = double.parse(myController.text) / 4.9;
        myControllerEur.text = _sum.toStringAsFixed(2);
      } else {
        _sum = double.parse(myController.text) * 5.0;
        myControllerEur.text = _sum.toStringAsFixed(2);
      }
    } else {
      _sum = 0.0;
      myControllerEur.text = "";
    }
  }

  void _convert() {
    setState(() {
      compute();
    });
  }

  void _change() {
    setState(() {
      if (_convertFrom == _convertFromRon) {
        _convertFrom = _convertFromEur;
        _currencyNo1 = _currencyNo2;
        _currencyNo2 = "RON";
      } else {
        _convertFrom = _convertFromRon;
        _currencyNo1 = _currencyNo2;
        _currencyNo2 = "EUR";
      }
      compute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network("https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/06/getty_currency-exchange_062321.jpeg.jpg"),
            Text(
              _convertFrom,
            ),
            Column(children: <Widget>[
              TextField(
                controller: myController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: _currencyNo1,
                ),
              ),
              TextField(
                controller: myControllerEur,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: _currencyNo2,
                ),
              ),
            ]),
            Text(
              // myController.text,
              '${myControllerEur.text} $_currencyNo2',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue, // foreground
              ),
              onPressed: _convert,
              child: const Text('Convert'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _change,
        tooltip: 'Convert',
        child: const Icon(Icons.cached),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
