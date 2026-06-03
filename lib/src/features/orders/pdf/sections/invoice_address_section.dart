import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/models/order_model.dart';

class InvoiceAddressSection {

  static pw.Widget build(
      OrderModel order,
      ) {

    final address =
        order.address;

    return pw.Column(

      crossAxisAlignment:
      pw.CrossAxisAlignment
          .start,

      children: [

        pw.Text(

          'Delivery Address',

          style:
          pw.TextStyle(

            fontSize: 18,

            fontWeight:
            pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 14),

        pw.Container(

          width: double.infinity,

          padding:
          const pw.EdgeInsets.all(16),

          decoration:
          pw.BoxDecoration(

            border:
            pw.Border.all(
              color:
              PdfColors.grey300,
            ),
          ),

          child: pw.Column(

            crossAxisAlignment:
            pw.CrossAxisAlignment
                .start,

            children: [

              pw.Text(

                address['name'] ?? '',

                style:
                pw.TextStyle(

                  fontWeight:
                  pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Text(
                '${address['address']}, ${address['city']} - ${address['zipCode']}',
              ),

              pw.SizedBox(height: 8),

              pw.Text(
                'Phone: ${address['phone']}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}