import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class InvoiceData {
  final List<Map<String, dynamic>> tabulatedData;
  final List<Map<String, dynamic>> summaryFields;
  final bool isInvoiceValid;

  InvoiceData({
    required this.tabulatedData,
    required this.summaryFields,
    required this.isInvoiceValid,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InvoiceData? invoiceData;

  @override
  void initState() {
    super.initState();
    loadInvoiceData();
  }

  Future<void> loadInvoiceData() async {
    try {
      // Read the JSON file from the assets folder
      final jsonString = await rootBundle.loadString('assets/Apextracted.json');

      final jsonMap = json.decode(jsonString);
      setState(() {
        invoiceData = InvoiceData(
          tabulatedData: List<Map<String, dynamic>>.from(jsonMap['TabulatedData']),
          summaryFields: List<Map<String, dynamic>>.from(jsonMap['SummaryFields']),
          isInvoiceValid: jsonMap['IsInvoiceValid'],
        );
      });
    } catch (error) {
      // Handle any errors that occur during loading
      print("Error loading JSON data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice App'),
      ),
      body: Center(
        child: invoiceData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Display your invoice data here using invoiceData
                  // Example: Display the product items
                  for (final product in invoiceData!.tabulatedData)
                    ListTile(
                      title: Text(product['ITEM'] ?? ''),
                      subtitle: Text('Price: \$${product['PRICE'] ?? ''}'),
                    ),
                ],
              ),
      ),
    );
  }
}
