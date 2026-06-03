import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/models/order_model.dart';
import '../helpers/pdf_helper.dart';

class InvoiceProductsSection {

  static pw.Widget build(
      OrderModel order,
      ) {

    return pw.Column(

      crossAxisAlignment:
      pw.CrossAxisAlignment
          .start,

      children: [

        pw.Text(

          'Products',

          style:
          pw.TextStyle(

            fontSize: 18,

            fontWeight:
            pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 18),

        pw.Table(

          border:
          pw.TableBorder.all(
            color:
            PdfColors.grey300,
          ),

          columnWidths: {

            0:
            const pw.FlexColumnWidth(4),

            1:
            const pw.FlexColumnWidth(1),

            2:
            const pw.FlexColumnWidth(2),

            3:
            const pw.FlexColumnWidth(2),
          },

          children: [

            pw.TableRow(

              decoration:
              const pw.BoxDecoration(
                color:
                PdfColors.grey200,
              ),

              children: [

                InvoicePdfHelpers.tableHeader(
                  'Product',
                ),

                InvoicePdfHelpers.tableHeader(
                  'Qty',
                ),

                InvoicePdfHelpers.tableHeader(
                  'Price',
                ),

                InvoicePdfHelpers.tableHeader(
                  'Total',
                ),
              ],
            ),

            ...order.items.map(
                  (item) {

                final quantity =
                item['quantity'];

                final price =
                (item['sellingPrice'] ?? 0)
                    .toDouble();

                final total =
                    quantity * price;

                return pw.TableRow(

                  children: [

                    InvoicePdfHelpers.tableCell(
                      item['title'],
                    ),

                    InvoicePdfHelpers.tableCell(
                      quantity.toString(),
                    ),

                    InvoicePdfHelpers.tableCell(
                      '₹${price.toStringAsFixed(0)}',
                    ),

                    InvoicePdfHelpers.tableCell(
                      '₹${total.toStringAsFixed(0)}',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}