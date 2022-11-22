// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:kelvin_project/app/models/transaction.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  // content true = product
  // content false = transaction

  static String? logo;
  static String? dateHeader;
  static List<ProductReportModel>? listProduct;

  static Future buildPdf(
      bool content, dynamic data, dynamic data2, String date) async {
    listProduct = data2;
    dateHeader = date;
    final doc = pw.Document();

    logo = await rootBundle
        .loadString('assets/images/logo/KLABELS_Logo_Front_Color_16-9.svg');

    var dataRegular = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    var dataBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    var dataItalic = await rootBundle.load("assets/fonts/Poppins-Italic.ttf");

    final ttfRegular = pw.Font.ttf(dataRegular.buffer.asByteData());
    final ttfBold = pw.Font.ttf(dataBold.buffer.asByteData());
    final ttfItalic = pw.Font.ttf(dataItalic.buffer.asByteData());

    doc.addPage(
      pw.MultiPage(
        pageTheme: PdfService.buildTheme(
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
              : contentTableTransaction(context, data),
          pw.SizedBox(height: 32),
          if (content == false) contentBottomTransaction()
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
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Container(
                child: pw.Center(
                  child: pw.SvgImage(svg: logo!, width: 200),
                ),
              ),
            ),
          ],
        ),
        pw.Text(
          'Periode : $dateHeader',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.right,
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget contentTableProduct(
    pw.Context context,
    List<ProductReportModel> listReportProduct,
  ) {
    int totalStockAllProduct = 0;
    for (var element in listReportProduct) {
      totalStockAllProduct += element.stock;
    }

    const tableHeaders = [
      'Nama Produk',
      'Harga',
      'Semua Stok',
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Table.fromTextArray(
          border: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerDecoration: const pw.BoxDecoration(
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
            color: PdfColors.green500,
          ),
          headerHeight: 25,
          cellHeight: 40,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
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
                color: PdfColors.green500,
                width: .5,
              ),
            ),
          ),
          headers: List<String>.generate(
            tableHeaders.length,
            (col) => tableHeaders[col],
          ),
          data: List<List<String>>.generate(
            listReportProduct.length,
            (row) => List<String>.generate(
              tableHeaders.length,
              (col) => listReportProduct[row].getIndex(col),
            ),
          ),
        ),
        pw.SizedBox(
          height: 24,
        ),
        pw.Text(
          'Total Seluruh Stok Produk : $totalStockAllProduct',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.right,
        ),
      ],
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
                child: pw.Center(
                  child: pw.SvgImage(svg: logo!, width: 200),
                ),
              ),
            ),
          ],
        ),
        pw.Text(
          'Periode : $dateHeader',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.right,
        ),
        pw.SizedBox(height: 16),
        // Header Table
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(
                width: 1.0,
                color: PdfColors.green400,
              ),
              bottom: pw.BorderSide(
                width: 1.0,
                color: PdfColors.green400,
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
                  'Varian',
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
      children: transactionReportData
          .map(
            (trans) => pw.Container(
              margin: const pw.EdgeInsets.only(top: 8),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    width: 1.0,
                    color: PdfColors.green400,
                  ),
                ),
              ),
              child: pw.Row(
                children: [
                  // Code Transaction
                  pw.Expanded(
                    fit: pw.FlexFit.loose,
                    child: pw.Container(
                      child: dataCellCustom(
                        trans.codeTransaction,
                        pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  // Product
                  pw.Expanded(
                    child: pw.Column(
                      mainAxisSize: pw.MainAxisSize.max,
                      children: trans.detailTrans.map(
                        (detailTrans) {
                          return pw.Column(
                            children: [
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: (5.8 * detailTrans.variant!.length)
                                      .toDouble(),
                                ),
                                child: dataCellCustom(
                                  detailTrans.productName,
                                  pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  // Varian
                  pw.Expanded(
                    child: pw.Column(
                      children: trans.detailTrans.map(
                        (detailTrans) {
                          return pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 5.5,
                            ),
                            child: pw.Column(
                              children: detailTrans.variant!
                                  .map(
                                    (val) => dataCellCustom(
                                      val['variantName'],
                                      pw.FontWeight.normal,
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  // Harga
                  pw.Expanded(
                    child: pw.Column(
                      children: trans.detailTrans
                          .map(
                            (detailTrans) => pw.Container(
                              padding: pw.EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: (5.8 * detailTrans.variant!.length)
                                    .toDouble(),
                              ),
                              child: dataCellCustom(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(
                                  detailTrans.price,
                                ),
                                pw.FontWeight.normal,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // Total Item Buy
                  pw.Expanded(
                    child: pw.Column(
                      children: trans.detailTrans
                          .map(
                            (detailTrans) => pw.Container(
                              padding: pw.EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: (5.8 * detailTrans.variant!.length)
                                    .toDouble(),
                              ),
                              child: pw.Column(
                                children: detailTrans.variant!
                                    .map(
                                      (val) => dataCellCustom(
                                        val['totalBuy'].toString(),
                                        pw.FontWeight.normal,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // Date Transaction
                  pw.Expanded(
                    child: dataCellCustom(
                      DateFormat.yMd().format(trans.dateTransaction.toDate()),
                      pw.FontWeight.normal,
                    ),
                  ),
                  // Price Item
                  pw.Expanded(
                    child: dataCellCustom(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp. ',
                        decimalDigits: 0,
                      ).format(
                        trans.totalPay,
                      ),
                      pw.FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  static pw.Widget contentBottomTransaction() {
    return pw.Column(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(
                width: 1.0,
                color: PdfColors.green400,
              ),
              bottom: pw.BorderSide(
                width: 1.0,
                color: PdfColors.green400,
              ),
            ),
          ),
          child: pw.Row(
            children: [
              pw.Expanded(
                child: dataCellCustom(
                  'Produk',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Terjual',
                  pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: dataCellCustom(
                  'Sisa Stok Barang',
                  pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.Column(
          children: listProduct!.map(
            (val) {
              return pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 8),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(
                      width: 1.0,
                      color: PdfColors.green400,
                    ),
                  ),
                ),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: dataCellCustom(
                        val.productName,
                        pw.FontWeight.normal,
                      ),
                    ),
                    pw.Expanded(
                      child: dataCellCustom(
                        val.sold.toString(),
                        pw.FontWeight.normal,
                      ),
                    ),
                    pw.Expanded(
                      child: dataCellCustom(
                        val.stock.toString(),
                        pw.FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  static pw.Widget dataCellCustom(String text, pw.FontWeight fontWeight) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 9,
        fontWeight: fontWeight,
      ),
      textAlign: pw.TextAlign.center,
    );
  }
}
