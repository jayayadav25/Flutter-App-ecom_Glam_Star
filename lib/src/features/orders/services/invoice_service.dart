import 'package:file_saver/file_saver.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../../core/models/order_model.dart';
import '../pdf/pdf_generator.dart';

class InvoiceService {

  static Future<void> generateInvoice(BuildContext context, OrderModel order,) async {
    try {
      final pdfBytes = Uint8List.fromList(
        await InvoicePdfGenerator.generate(order),);
      await FileSaver.instance.saveFile(
        name: 'GlamStar_Invoice_${order.id.substring(0, 6)}',
        bytes: pdfBytes,
        ext: 'pdf',
        mimeType:
        MimeType.pdf,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invoice downloaded successfully',
            ),
          ),
        );
      }

    } catch (e, stackTrace) {

      debugPrint('INVOICE ERROR: $e',);
      debugPrint('STACKTRACE: $stackTrace',);
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Invoice Error',),
              content: Text(
                e.toString(),
              ),
            );
          },
        );
      }
    }
  }
}