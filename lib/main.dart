import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CurrencyConverter());
}

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});

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
  final String messageConvertFromEur = "Convert from EUR to RON";
  final String messageConvertFromRon = "Convert from RON to EUR";
  double sum = 0.0;
  String messageConvertFrom = "Convert from RON to EUR";
  String? error;
  double? inputValue;
  String currencyNo1 = "RON";
  String currencyNo2 = "EUR";
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void compute() {
    setState(() {
      if (myController.text.isNotEmpty) {
        if (currencyNo1 == "RON") {
          sum = double.parse(myController.text) / 4.9;
        } else {
          sum = double.parse(myController.text) * 5.0;
        }
      } else {
        sum = 0.0;
        myController.text = "";
      }
    });
  }

  void changeCurrencies() {
    setState(() {
      if (messageConvertFrom == messageConvertFromRon) {
        messageConvertFrom = messageConvertFromEur;
        currencyNo1 = currencyNo2;
        currencyNo2 = "RON";
      } else {
        messageConvertFrom = messageConvertFromRon;
        currencyNo1 = currencyNo2;
        currencyNo2 = "EUR";
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(
                  "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/06/getty_currency-exchange_062321.jpeg.jpg"),
              Text(
                messageConvertFrom,
              ),
              Column(children: <Widget>[
                TextField(
                  controller: myController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (String input) {
                    setState(() => {
                          if (input.isEmpty)
                            {error = "Please enter a number", sum = 0}
                          else
                            {
                              inputValue = double.tryParse(input),
                              if (inputValue == null)
                                {
                                  sum = 0,
                                  error =
                                      "Incorrect format - Please enter only numbers"
                                }
                              else
                                {error = null}
                            }
                        });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: currencyNo1,
                    errorText: error,
                  ),
                ),
              ]),
              Text(
                '${sum.toStringAsFixed(2)} $currencyNo2',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlue, // foreground
                ),
                onPressed: compute,
                child: const Text('Convert'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeCurrencies,
        tooltip: 'Convert',
        child: const Icon(Icons.cached),
      ),
    );
  }
}
