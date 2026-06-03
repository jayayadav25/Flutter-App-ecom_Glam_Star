import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/models/order_model.dart';
import '../helpers/pdf_helper.dart';

class InvoicePriceSection {

  static pw.Widget build(
      OrderModel order,
      ) {

    return pw.Align(

      alignment:
      pw.Alignment.centerRight,

      child: pw.Container(

        width: 260,

        padding:
        const pw.EdgeInsets.all(18),

        decoration:
        pw.BoxDecoration(

          border:
          pw.Border.all(
            color:
            PdfColors.grey300,
          ),
        ),

        child: pw.Column(

          children: [

            InvoicePdfHelpers.priceRow(
              'Actual Price',
              '₹${order.actualPrice.toStringAsFixed(0)}',
            ),

            InvoicePdfHelpers.priceRow(
              'Selling Price',
              '₹${order.sellingPrice.toStringAsFixed(0)}',
            ),

            InvoicePdfHelpers.priceRow(
              'Product Discount',
              '- ₹${order.productDiscount.toStringAsFixed(0)}',
            ),

            InvoicePdfHelpers.priceRow(
              'Coupon Discount',
              '- ₹${order.couponDiscount.toStringAsFixed(0)}',
            ),

            InvoicePdfHelpers.priceRow(
              'Offer Discount',
              '- ₹${order.offerDiscount.toStringAsFixed(0)}',
            ),

            InvoicePdfHelpers.priceRow(

              'Shipping Fee',

              order.shippingFee == 0
                  ? 'FREE'
                  : '₹${order.shippingFee.toStringAsFixed(0)}',
            ),

            pw.Divider(),

            InvoicePdfHelpers.priceRow(

              'Total Amount',

              '₹${order.totalAmount.toStringAsFixed(0)}',

              bold: true,
            ),
          ],
        ),
      ),
    );
  }
}