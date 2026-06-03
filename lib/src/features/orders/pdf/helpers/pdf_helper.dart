import 'package:pdf/widgets.dart' as pw;

class InvoicePdfHelpers {

  static pw.Widget label(String text,) {
    return pw.Text(text,
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  static pw.Widget tableHeader(String text,) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget tableCell(String text,) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(text),
    );
  }

  static pw.Widget priceRow(String title, String value, {bool bold = false,}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12,),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.Text(value,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}