import 'package:firebase_mastery_app/src/features/orders/pdf/pdf_theme.dart';
import 'package:firebase_mastery_app/src/features/orders/pdf/sections/invoice_footor_section.dart';
import 'package:firebase_mastery_app/src/features/orders/pdf/sections/invoice_product_section.dart';
import 'package:firebase_mastery_app/src/features/orders/pdf/sections/order_info_sections.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/order_model.dart';
import 'sections/invoice_header_section.dart';
import 'sections/invoice_address_section.dart';
import 'sections/invoice_price_section.dart';

class InvoicePdfGenerator {

  static Future<List<int>> generate(OrderModel order,) async {

    final regularFontData = await rootBundle.load('assets/fonts/NotoSans-Regular.ttf',);
    final boldFontData = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf',);
    final regularFont = pw.Font.ttf(regularFontData,);
    final boldFont = pw.Font.ttf(boldFontData,);
    final theme = InvoicePdfTheme.build(regularFont, boldFont,);
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        theme: theme,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (_) {
          return [
            InvoiceHeaderSection.build(order,),
            pw.SizedBox(height: 28),
            InvoiceOrderInfoSection.build(order,),
            pw.SizedBox(height: 32),
            InvoiceAddressSection.build(order,),
            pw.SizedBox(height: 34),
            InvoiceProductsSection.build(order,),
            pw.SizedBox(height: 36),
            InvoicePriceSection.build(order,),
            pw.SizedBox(height: 40),
            InvoiceFooterSection.build(),
          ];
        },
      ),
    );

    return pdf.save();
  }
}