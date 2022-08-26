// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  // content true = product
  // content false = transaction

  static String? logo;

  static Future buildPdf(bool content) async {
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
              ? contentTableProduct(context)
              : contentTableTransaction(context)
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
                child: pw.Center(
                  child: pw.SvgImage(svg: logo!, width: 200),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget contentTableProduct(pw.Context context) {
    const tableHeaders = [
      'Nama Produk',
      'Kategori',
      'Harga',
      'Semua Stok',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.pink400,
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
            color: PdfColors.pink500,
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
        // Header Table
        pw.Row(
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
      ],
    );
  }

  static pw.Widget contentTableTransaction(pw.Context context) {
    return pw.Column(
      children: [
        // Data Table
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            // Kode Transaction
            pw.Expanded(
              child: dataCellCustom(
                'TR-KL-2022-15-05-WBDHABHSBDHW',
                pw.FontWeight.normal,
              ),
            ),
            // Product
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Column(
                  children: [
                    dataCellCustom(
                      'Baju 3 Seconds',
                      pw.FontWeight.normal,
                    ),
                    dataCellCustom(
                      'Baju Emak Emak',
                      pw.FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            // Varian
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Merah | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Pink | XL',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Putih | M',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Merah | L',
                            style: const pw.TextStyle(
                              fontSize: 9,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Harga
            pw.Expanded(
              child: dataCellCustom(
                'Rp. 300.000',
                pw.FontWeight.normal,
              ),
            ),
            // Total Item Buy
            pw.Expanded(
              child: dataCellCustom(
                '4 Unit',
                pw.FontWeight.normal,
              ),
            ),
            // Date Transaction
            pw.Expanded(
              child: dataCellCustom(
                '24 Mar 2022',
                pw.FontWeight.normal,
              ),
            ),
            // Price Item
            pw.Expanded(
              child: dataCellCustom(
                'Rp.540.000',
                pw.FontWeight.normal,
              ),
            ),
          ],
        )
      ],
    );
  }
}

pw.Widget dataCellCustom(String text, pw.FontWeight fontWeight) {
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
