// lib/invoice_data.dart

import 'dart:convert';

class InvoiceData {
  final List<Map<String, dynamic>> tabulatedData;

  InvoiceData({required this.tabulatedData});

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      tabulatedData: List<Map<String, dynamic>>.from(json['TabulatedData']),
    );
  }
}

