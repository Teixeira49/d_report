import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AppTextStyle {
  // ----------Black----------//

  static final smallBlack = pw.TextStyle(
    fontSize: 12,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.normal,
  );

  static final smallTitleBlack = pw.TextStyle(
    fontSize: 12,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
  );

  static final smallTableBlack = pw.TextStyle(
    fontSize: 12,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.normal,
    lineSpacing: 4
  );

  static final mediumBlack = pw.TextStyle(
    fontSize: 14,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
  );

  static final mediumTitleBlack = pw.TextStyle(
    fontSize: 14,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
    lineSpacing: 4,
    decoration: pw.TextDecoration.underline
  );

  static final largeBlack = pw.TextStyle(
    fontSize: 24,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.normal,
  );

  static final mainTitleBlack = pw.TextStyle(
    fontSize: 14,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
  );

  static final headerDecoratedBlack = pw.TextStyle(
    fontSize: 10,
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
    fontStyle: pw.FontStyle.italic,
  );

  // ----------White----------//

  static final smallWhite = pw.TextStyle(
    fontSize: 12,
    color: PdfColors.white,
    fontWeight: pw.FontWeight.normal,
  );

  static final mediumWhite = pw.TextStyle(
    fontSize: 14,
    color: PdfColors.white,
    fontWeight: pw.FontWeight.normal,
  );

  static final largeWhite = pw.TextStyle(
    fontSize: 24,
    color: PdfColors.white,
    fontWeight: pw.FontWeight.normal,
  );

  static final mainTitleWhite = pw.TextStyle(
    fontSize: 15,
    color: PdfColors.white,
    fontWeight: pw.FontWeight.bold,
  );

  static final headerDecoratedWhite = pw.TextStyle(
    fontSize: 10,
    color: PdfColors.white,
    fontWeight: pw.FontWeight.bold,
    fontStyle: pw.FontStyle.italic,
  );
}
