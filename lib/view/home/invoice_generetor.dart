import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../controller/order_controller.dart' show OrderItem;

class InvoiceGenerator {
  // Generate PDF invoice
  static Future<File> generateInvoice({
    required String orderId,
    required String customerName,
    required String orderDate,
    required String deliveryAddress,
    required List<OrderItem> foodItems,
    required double itemTotal,
    required double deliveryCharge,
    required double totalAmount,
    required String orderStatus,
  }) async {
    final pdf = pw.Document();
    // ignore: unused_local_variable
    final font = pw.Font.ttf(await rootBundle
        .load("assets/font/sofia-pro/Sofia Pro Regular Az.otf"));
    final fontBold = pw.Font.ttf(
        await rootBundle.load("assets/font/sofia-pro/Sofia Pro Bold Az.otf"));
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('INVOICE',
                        style: pw.TextStyle(
                            fontBold: pw.Font.timesBoldItalic(),
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Text('Food Hub',
                        style: pw.TextStyle(
                            fontBold: pw.Font.timesBoldItalic(),
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.SizedBox(height: 20),

              // Order Info
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Order ID: $orderId',
                            style: pw.TextStyle(
                                font: pw.Font.timesItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 5),
                        pw.Text('Date: $orderDate',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 5),
                        pw.Text('Status: $orderStatus',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesItalic(),
                                fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Customer Details:',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 5),
                        pw.Text(customerName,
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 5),
                        pw.Container(
                          width: 200,
                          child: pw.Text(deliveryAddress,
                              maxLines: 3,
                              style: pw.TextStyle(
                                  fontBold: pw.Font.timesItalic(),
                                  fontWeight: pw.FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Table Header
              pw.Container(
                color: PdfColors.grey300,
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text('No.',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        flex: 5,
                        child: pw.Text('Item',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text('Qty',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Text('Price',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Text('Total',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold))),
                  ],
                ),
              ),

              // Items
              // Corrected unit price calculation - inside the items loop in the generateInvoice method
              pw.Column(
                children: List.generate(foodItems.length, (index) {
                  final item = foodItems[index];
                  // Safeguard against division by zero and ensure proper calculation
                  final unitPrice =
                      (item.total.isNotEmpty && item.quantity.toString() != "0")
                          ? (double.tryParse(item.total) ?? 0.0) /
                              (int.tryParse(item.quantity.toString()) ??
                                  1) // ✅ Convert safely
                          : (double.tryParse(item.total) ?? 0.0);

                  return pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.grey300)),
                    ),
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 8, horizontal: 5),
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text('${index + 1}',
                              style: pw.TextStyle(
                                  fontBold: pw.Font.timesItalic(),
                                  fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Expanded(
                          flex: 5,
                          child: pw.Text(item.foodName ?? 'Unknown',
                              style: pw.TextStyle(
                                  fontBold: pw.Font.timesItalic(),
                                  fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text('${item.quantity}',
                              style: pw.TextStyle(
                                  fontBold: pw.Font.timesItalic(),
                                  fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Expanded(
                            flex: 2,
                            child: pw.Text('Rs ${unitPrice.toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                    fontBold: pw.Font.timesItalic(),
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text('Rs ${item.total}',
                              style: pw.TextStyle(
                                  fontBold: pw.Font.timesItalic(),
                                  fontWeight: pw.FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              pw.SizedBox(height: 20),

              // Summary
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Text('Subtotal:',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 50),
                        pw.Text('Rs ${itemTotal.toStringAsFixed(2)}',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesItalic(),
                                fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Text('Delivery Charge:',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 50),
                        pw.Text('Rs ${deliveryCharge.toStringAsFixed(2)}',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesItalic(),
                                fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.Divider(),
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Text('Total:',
                            style: pw.TextStyle(
                                fontBold: pw.Font.timesBoldItalic(),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 50),
                        pw.Text(
                          'Rs ${totalAmount.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                              fontBold: pw.Font.timesBoldItalic(),
                              fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Center(
                child: pw.Text('Thank you for ordering with Food Hub!',
                    style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                    'Generated on ${DateFormat('dd MMM yyyy HH:mm').format(DateTime.now())}',
                    style: pw.TextStyle(
                        fontBold: pw.Font.timesItalic(),
                        fontWeight: pw.FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF
    final output = await getTemporaryDirectory();
    final String fileName = 'FoodHub_Invoice_$orderId.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  // Method to generate and open PDF
  static Future<void> generateAndDownloadInvoice({
    required String orderId,
    required String customerName,
    required String orderDate,
    required String deliveryAddress,
    required List<OrderItem> foodItems,
    required double itemTotal,
    required double deliveryCharge,
    required double totalAmount,
    required String orderStatus,
    required BuildContext context,
  }) async {
    try {
      final file = await generateInvoice(
        orderId: orderId,
        customerName: customerName,
        orderDate: orderDate,
        deliveryAddress: deliveryAddress,
        foodItems: foodItems,
        itemTotal: itemTotal,
        deliveryCharge: deliveryCharge,
        totalAmount: totalAmount,
        orderStatus: orderStatus,
      );

      // Show options to open or share
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.visibility),
                  title: const Text('View Invoice'),
                  onTap: () async {
                    Navigator.pop(context);
                    await OpenFile.open(file.path);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share Invoice'),
                  onTap: () async {
                    Navigator.pop(context);
                    await Share.shareFiles(
                      [file.path],
                      text: 'Your Food Hub Order Invoice - $orderId',
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      debugPrint("============>${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate invoice: ${e.toString()}')),
      );
    }
  }
}
