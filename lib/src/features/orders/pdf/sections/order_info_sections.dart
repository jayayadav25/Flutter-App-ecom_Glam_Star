import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/models/order_model.dart';
import '../helpers/pdf_helper.dart';

class InvoiceOrderInfoSection {

  static pw.Widget build(
      OrderModel order,
      ) {

    return pw.Container(

      padding:
      const pw.EdgeInsets.all(18),

      decoration:
      pw.BoxDecoration(
        color:
        PdfColors.grey100,
      ),

      child: pw.Row(

        mainAxisAlignment:
        pw.MainAxisAlignment
            .spaceBetween,

        children: [

          pw.Column(

            crossAxisAlignment:
            pw.CrossAxisAlignment
                .start,

            children: [

              InvoicePdfHelpers.label(
                'Order ID',
              ),

              pw.SizedBox(height: 6),

              pw.Text(order.id),

              pw.SizedBox(height: 18),

              InvoicePdfHelpers.label(
                'Payment Method',
              ),

              pw.SizedBox(height: 6),

              pw.Text(
                order.paymentMethod,
              ),
            ],
          ),

          pw.Column(

            crossAxisAlignment:
            pw.CrossAxisAlignment
                .start,

            children: [

              InvoicePdfHelpers.label(
                'Order Date',
              ),

              pw.SizedBox(height: 6),

              pw.Text(
                '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
              ),

              pw.SizedBox(height: 18),

              InvoicePdfHelpers.label(
                'Order Status',
              ),

              pw.SizedBox(height: 6),

              pw.Text(
                order.status,
              ),
            ],
          ),
        ],
      ),
    );
  }
}