import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_hub_user/controller/online_payment_controller.dart';
import 'package:food_hub_user/controller/order_controller.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/component/common_app_bar.dart';
import '../../core/component/common_button.dart';
import '../../core/const/text_style.dart';
import 'invoice_generetor.dart' show InvoiceGenerator;

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrderController orderController = Get.put(OrderController());
  final OnlinePaymentController onlinePaymentController = Get.put(OnlinePaymentController());
  bool isGeneratingPdf = false;

  @override
  void initState() {
    super.initState();
    orderController.fetchOrderDetails(widget.orderId);
  }

  Future<void> generateAndDownloadPDF() async {
    setState(() {
      isGeneratingPdf = true;
    });

    try {
      final pdf = pw.Document();

      // Load fonts
      final fontData = await rootBundle.load("assets/font/sofia-pro/Sofia Pro Regular Az.otf");
      final fontDataBold = await rootBundle.load("assets/font/sofia-pro/Sofia Pro Bold Az.otf");
      final ttf = pw.Font.ttf(fontData);
      final ttfBold = pw.Font.ttf(fontDataBold);

      // Get order details
      final orderId = orderController.orderDetails['orderId'] ?? '';
      final orderDate = orderController.getOrderDate();
      final userName = orderController.userDetails['name'] ?? '';
      final deliveryAddress = orderController.getDeliveryAddress();
      final foodItems = orderController.foodItems;
      final totalItemBill = orderController.calculateTotalBill();
      final deliveryCharge = orderController.getDeliveryCharge();
      final totalBillWithDelivery = orderController.getTotalBillWithDelivery();
      final orderStatus = orderController.getOrderStatus();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'FOOD HUB',
                    style: pw.TextStyle(
                      font: ttfBold,
                      fontSize: 24,
                      color: PdfColors.orange,
                    ),
                  ),
                  pw.Text(
                    'INVOICE',
                    style: pw.TextStyle(
                      font: ttfBold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(color: PdfColors.orange),
              pw.SizedBox(height: 20),

              // Order Info
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Order ID:', style: pw.TextStyle(font: ttfBold)),
                        pw.Text(orderId, style: pw.TextStyle(font: ttf)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Date:', style: pw.TextStyle(font: ttfBold)),
                        pw.Text(orderDate, style: pw.TextStyle(font: ttf)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Status:', style: pw.TextStyle(font: ttfBold)),
                        pw.Text(
                          orderStatus,
                          style: pw.TextStyle(
                            font: ttfBold,
                            color: orderStatus == 'Delivered'
                                ? PdfColors.green
                                : orderStatus == 'Cancelled'
                                    ? PdfColors.red
                                    : PdfColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Customer Info
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Customer:', style: pw.TextStyle(font: ttfBold)),
                          pw.SizedBox(height: 5),
                          pw.Text(userName, style: pw.TextStyle(font: ttf)),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Delivery Address:', style: pw.TextStyle(font: ttfBold)),
                          pw.SizedBox(height: 5),
                          pw.Text(deliveryAddress, style: pw.TextStyle(font: ttf)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Items Table
              pw.Text('Order Items', style: pw.TextStyle(font: ttfBold, fontSize: 16)),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(1),
                },
                children: [
                  // Header row
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Item', style: pw.TextStyle(font: ttfBold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Quantity', style: pw.TextStyle(font: ttfBold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Price', style: pw.TextStyle(font: ttfBold)),
                      ),
                    ],
                  ),
                  // Item rows
                  ...foodItems.map(
                    (item) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child:
                              pw.Text(item.foodName ?? 'Unknown', style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            item.quantity.toString(),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '₹${item.total}',
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // Bill Summary
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Container(
                          width: 120,
                          child: pw.Text('Total Item Bill:', style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Container(
                          width: 80,
                          child: pw.Text(
                            '₹$totalItemBill',
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Container(
                          width: 120,
                          child: pw.Text('Delivery Charge:', style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Container(
                          width: 80,
                          child: pw.Text(
                            '₹$deliveryCharge',
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Divider(color: PdfColors.grey),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Container(
                          width: 120,
                          child: pw.Text('Total Amount:', style: pw.TextStyle(font: ttfBold)),
                        ),
                        pw.Container(
                          width: 80,
                          child: pw.Text(
                            '₹$totalBillWithDelivery',
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(font: ttfBold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer
              pw.SizedBox(height: 40),
              pw.Divider(),
              pw.Center(
                child: pw.Text(
                  'Thank you for your order!',
                  style: pw.TextStyle(font: ttf, fontSize: 14),
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text(
                  'Food Hub - Delicious meals delivered to your doorstep',
                  style: pw.TextStyle(font: ttf, fontSize: 10, color: PdfColors.grey700),
                ),
              ),
            ];
          },
        ),
      );

      // Save and open the PDF
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/Invoice-$orderId.pdf");
      await file.writeAsBytes(await pdf.save());

      // Open the PDF file
      await OpenFile.open(file.path);

      Get.snackbar("Success", "Invoice downloaded successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to generate invoice: ${e.toString()}");
    } finally {
      setState(() {
        isGeneratingPdf = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(text: "Order Details"),
      body: Obx(() {
        if (orderController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Container
                Container(
                  height: 80,
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: Row(
                    children: [
                      10.sizeWidth,
                      _buildStatusIcon(orderController.getOrderStatus()),
                      10.sizeWidth,
                      Text(
                        orderController.getOrderStatus(),
                        style: AppTextStyle.w700(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // Food Items List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "${orderController.foodItems.length} food items in Order",
                    style: AppTextStyle.w600(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),

                // Inside your ListView.builder for food items:
                SizedBox(
                  height: orderController.foodItems.length * 60,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderController.foodItems.length,
                    itemBuilder: (context, index) {
                      final OrderItem item = orderController.foodItems[index];

                      final String base64Image = item.foodImage.toString();
                      final decodedImage = base64Decode(base64Image);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(image: MemoryImage(decodedImage))),
                            ),
                            10.sizeWidth,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.foodName ?? 'Unknown Food',
                                    style: AppTextStyle.w700(fontSize: 14)),
                                Text("${item.quantity} item",
                                    style: AppTextStyle.w600(fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            Text("₹${item.total}", style: AppTextStyle.w700(fontSize: 14)),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Divider(thickness: 5),
                _buildSectionHeader(Icons.receipt, "Bill Summary"),
                10.sizeHeight,
                _buildRow("Total item Bill", orderController.calculateTotalBill().toString()),
                const Divider(),
                _buildRow("Delivery Charge", orderController.getDeliveryCharge().toString()),
                const Divider(),
                _buildRow("Total Bill", orderController.getTotalBillWithDelivery().toString()),

                // Download Button - Updated with Modern Design
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: isGeneratingPdf
                        ? null
                        : () async {
                            setState(() {
                              isGeneratingPdf = true;
                            });

                            await InvoiceGenerator.generateAndDownloadInvoice(
                              orderId: orderController.orderDetails["orderId"],
                              customerName: orderController.userDetails["name"],
                              orderDate: orderController.getOrderDate(),
                              deliveryAddress: orderController.getDeliveryAddress(),
                              foodItems: orderController.foodItems,
                              itemTotal: orderController.calculateTotalBill(),
                              deliveryCharge: orderController.getDeliveryCharge(),
                              totalAmount: orderController.getTotalBillWithDelivery(),
                              orderStatus: orderController.getOrderStatus(),
                              context: context,
                            );

                            setState(() {
                              isGeneratingPdf = false;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: isGeneratingPdf
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Download Invoice",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                  ),
                ).paddingSymmetric(vertical: 10, horizontal: 10),

                // ElevatedButton(onPressed: () {}, child: Text("Download")),

                // Align(
                //   alignment: Alignment.topRight,
                //   child: CommonButton(
                //     onPressed: () {
                //
                //     },
                //     text: isGeneratingPdf ? "Generating..." : "Download",
                //   ),
                // ).paddingSymmetric(horizontal: 15, vertical: 10),

                const Divider(thickness: 5),
                _buildSectionHeader(Icons.location_on_outlined, "Order Details"),
                15.sizeHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildColumn("Order ID", orderController.orderDetails['orderId'] ?? ''),
                    const Divider(),
                    _buildColumn("Order Address", orderController.getDeliveryAddress()),
                    const Divider(),
                    _buildColumn("Order Date", orderController.getOrderDate()),
                    const Divider(),
                    _buildColumn("Receiver Details", orderController.userDetails['name'] ?? ''),
                    const Divider(thickness: 5),
                  ],
                ),

                // Cancel Order Button (Only if order is not cancelled)
                Center(
                  child: Obx(() {
                    return orderController.getOrderStatus() != "Cancelled"
                        ? CommonButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Are you sure you want to cancel this order?",
                                      style: AppTextStyle.w700(fontSize: 18),
                                    ),
                                    actions: [
                                      CommonButton(
                                        height: 30,
                                        width: 80,
                                        onPressed: () async {
                                          String orderId = orderController.orderDetails['orderId'];
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(orderId)
                                                .update({'status': 'Cancelled'});

                                            // Update order status in GetX state
                                            orderController.updateOrderStatus("Cancelled");

                                            Get.back();
                                            Get.snackbar("Success", "Order has been cancelled");
                                          } catch (e) {
                                            Get.snackbar("Error", "Failed to cancel order");
                                          }
                                        },
                                        text: "Yes",
                                      ),
                                      CommonButton(
                                        height: 30,
                                        width: 80,
                                        text: "No",
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            text: "Cancel Order",
                          )
                        : const SizedBox(); // Hide button if already cancelled
                  }),
                ).paddingSymmetric(horizontal: 10, vertical: 10),

                10.sizeHeight,
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildColumn(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.w700(fontSize: 14)),
        Text(subtitle),
      ],
    ).paddingSymmetric(horizontal: 15);
  }

  Widget _buildRow(String text, String price) {
    return Row(
      children: [
        Text(text),
        const Spacer(),
        Text("₹$price", style: AppTextStyle.w700(fontSize: 14)),
      ],
    ).paddingSymmetric(horizontal: 15);
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey),
        Text(title, style: AppTextStyle.w700(fontSize: 15)),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  Widget _buildStatusIcon(String status) {
    Color iconColor;
    switch (status) {
      case "Pending":
        iconColor = Colors.yellow.shade700;
        break;
      case "Cancelled":
        iconColor = Colors.red.shade700;
        break;
      case "Delivered":
        iconColor = Colors.green.shade700;
        break;
      default:
        iconColor = Colors.grey;
    }
    return Container(
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(color: iconColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Icon(Icons.alarm, color: iconColor),
    );
  }
}
