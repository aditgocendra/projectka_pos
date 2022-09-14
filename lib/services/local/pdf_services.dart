// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:projectka_pos/app/models/product.dart';
import 'package:projectka_pos/app/models/transaction.dart';
import 'package:projectka_pos/core/utils/string.util.dart';

class PdfServices {
  static String? logo;
  static String? dateHeader;

  static Future buildPdf(bool content, dynamic data, date) async {
    dateHeader = date;
    final doc = pw.Document();

    // logo = await rootBundle.loadString('assets/images/logo_test.png');

    var dataRegular = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    var dataBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    var dataItalic = await rootBundle.load("assets/fonts/Poppins-Italic.ttf");

    final ttfRegular = pw.Font.ttf(dataRegular.buffer.asByteData());
    final ttfBold = pw.Font.ttf(dataBold.buffer.asByteData());
    final ttfItalic = pw.Font.ttf(dataItalic.buffer.asByteData());

    doc.addPage(
      pw.MultiPage(
        pageTheme: PdfServices.buildTheme(
          PdfPageFormat.a4,
          ttfRegular,
          ttfBold,
          ttfItalic,
        ),
        header: content ? buildHeaderProduct : buildHeaderTransaction,
        build: (context) => [
          // contentHeader(context),
          content
              ? contentTableProduct(context, data)
              : contentTableTransaction(context, data)
        ],
      ),
    );

    List<int> bytes = await doc.save();
    AnchorElement anchor = AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}",
    );

    anchor.download = content ? 'Laporan-Produk.pdf' : 'Laporan-Transaksi.pdf';
    anchor.click();
  }

  static pw.PageTheme buildTheme(
    PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
    pw.Font italic,
  ) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  static pw.Widget buildHeaderProduct(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Container(
                  // child: pw.Center(
                  //   child: pw.SvgImage(svg: logo!, width: 200),
                  // ),
                  ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget contentTableProduct(
    pw.Context context,
    List<ProductModel> productData,
  ) {
    const tableHeaders = [
      'Nama Produk',
      'Harga',
      'Stok',
      'Terjual',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.black,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        productData.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => productData[row].getIndex(col),
        ),
      ),
    );
  }

  static pw.Widget buildHeaderTransaction(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Container(
                  // child: pw.Center(
                  //   child: pw.SvgImage(svg: logo!, width: 200),
                  // ),
                  ),
            ),
          ],
        ),
        pw.Text('Periode : $dateHeader',
            style: const pw.TextStyle(fontSize: 10),
            textAlign: pw.TextAlign.right),
        pw.SizedBox(height: 16),
        // Header Table
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(
                width: 1.0,
                color: PdfColors.black,
              ),
              bottom: pw.BorderSide(
                width: 1.0,
                color: PdfColors.black,
              ),
            ),
          ),
          child: pw.Row(
            children: [
              pw.Expanded(
                child: dataCellCustom(
                  'Kode Transaksi',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Produk',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Harga',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Jumlah Pembelian',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Tanggal Transaksi',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Total Pembayaran',
                  pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  static pw.Widget contentTableTransaction(
    pw.Context context,
    List<TransactionReport> transactionReportData,
  ) {
    return pw.Column(
      children: transactionReportData.map(
        (trans) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 8),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  width: 1.0,
                  color: PdfColors.black,
                ),
              ),
            ),
            child: pw.Row(
              children: [
                // Kode Transaction
                pw.Expanded(
                  child: dataCellCustom(
                    trans.codeTransaction,
                    pw.FontWeight.normal,
                  ),
                ),
                // Product
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Column(
                        children: trans.detailTrans.map(
                      (detailTrans) {
                        return dataCellCustom(
                          detailTrans.productName,
                          pw.FontWeight.normal,
                        );
                      },
                    ).toList()),
                  ),
                ),
                // Harga
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Column(
                      children: trans.detailTrans.map(
                        (detailTrans) {
                          return dataCellCustom(
                            StringUtil.rupiahFormat(detailTrans.price),
                            pw.FontWeight.normal,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                // Total Item Buy
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Column(
                        children: trans.detailTrans.map(
                      (detailTrans) {
                        return dataCellCustom(
                          '${detailTrans.totalBuy} Unit',
                          pw.FontWeight.normal,
                        );
                      },
                    ).toList()),
                  ),
                ),
                // Date Transaction
                pw.Expanded(
                  child: dataCellCustom(
                    StringUtil.dMMMyFormat(trans.dateTransaction.toDate()),
                    pw.FontWeight.normal,
                  ),
                ),
                // Price Item
                pw.Expanded(
                  child: dataCellCustom(
                    StringUtil.rupiahFormat(trans.totalPay),
                    pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  static pw.Widget dataCellCustom(String text, pw.FontWeight fontWeight) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: fontWeight,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}
