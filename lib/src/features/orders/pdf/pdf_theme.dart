import 'package:pdf/widgets.dart' as pw;

class InvoicePdfTheme {
  static pw.ThemeData build(
      pw.Font regularFont,
      pw.Font boldFont,
      ) {
    return pw.ThemeData.withFont(
      base: regularFont,
      bold: boldFont,
    );
  }
}