import 'package:pdf/widgets.dart' as pw;

import '../../../../core/models/order_model.dart';

class InvoiceHeaderSection {

  static pw.Widget build(
      OrderModel order,
      ) {

    return pw.Row(

      mainAxisAlignment:
      pw.MainAxisAlignment
          .spaceBetween,

      children: [

        pw.Column(

          crossAxisAlignment:
          pw.CrossAxisAlignment
              .start,

          children: [

            pw.Text(

              'GLAM STAR',

              style:
              pw.TextStyle(

                fontSize: 30,

                fontWeight:
                pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 4),

            pw.Text(
              'Luxury Fashion Invoice',
            ),
          ],
        ),

        pw.Container(

          padding:
          const pw.EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),

          decoration:
          pw.BoxDecoration(

            border:
            pw.Border.all(),
          ),

          child: pw.Text(

            order.paymentStatus,

            style:
            pw.TextStyle(

              fontWeight:
              pw.FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}