import 'package:pdf/widgets.dart' as pw;

class InvoiceFooterSection {

  static pw.Widget build() {

    return pw.Center(

      child: pw.Column(

        children: [

          pw.Text(

            'Thank you for shopping with Glam Star',

            style:
            pw.TextStyle(

              fontWeight:
              pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 8),

          pw.Text(
            'This is a computer generated invoice.',
          ),
        ],
      ),
    );
  }
}