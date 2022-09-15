import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/utils/styles.dart';
import 'package:kelvin_project/app/models/variant_product.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageTransaction extends StatelessWidget {
  ManageTransaction({Key? key}) : super(key: key);
  final mTransactionCtl = Get.find<ManageTransactionController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: screenSize > 780
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pengelolaan Transaksi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            mTransactionCtl.errorMessageReport.value = '';
                            showDialog(
                              context: context,
                              builder: (context) => DialogPdfReport(),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  UniconsLine.document_info,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Buat Laporan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            mTransactionCtl.resetFormProduct();
                            showDialog(
                              context: context,
                              builder: (context) => DialogFormTransaction(),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  UniconsLine.plus_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Tambah Transaksi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pengelolaan Transaksi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        // PdfService.buildPdf(false);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              UniconsLine.document_info,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Buat Laporan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        mTransactionCtl.resetFormProduct();
                        showDialog(
                          context: context,
                          builder: (context) => DialogFormTransaction(),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              UniconsLine.plus_circle,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Tambah Transaksi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
        TransactionTable(
          screenSize: screenSize,
        )
      ],
    );
  }
}

class DialogFormTransaction extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  DialogFormTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      elevation: 0.5,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(32.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transaksi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      UniconsLine.times_circle,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: mTransactionCtl.codeProductTec,
                        style: const TextStyle(fontSize: 14),
                        cursorColor: primaryColor,
                        decoration:
                            GlobalStyles.formInputDecoration('Kode Produk'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Obx(
                    () {
                      if (mTransactionCtl.isLoadingGetProduct.value) {
                        return LoadingAnimationWidget.inkDrop(
                          color: primaryColor,
                          size: 40,
                        );
                      }

                      return IconButton(
                        onPressed: () {
                          mTransactionCtl.addFormProduct();
                        },
                        icon: const Icon(
                          UniconsLine.plus_circle,
                          color: primaryColor,
                        ),
                      );
                    },
                  )
                ],
              ),
              // Warning Error
              Obx(
                () => Text(
                  mTransactionCtl.errorMessageForm.value,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
              // Form Product Transaction
              GetBuilder(
                init: mTransactionCtl,
                builder: (_) => ListView.builder(
                  itemCount: mTransactionCtl.listProductForm.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => FormProductTransaction(
                    indexProduct: index,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Bayar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp. ',
                          decimalDigits: 0,
                        ).format(mTransactionCtl.totalPay.value),
                        style: const TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  mTransactionCtl.createTransaction();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0.5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Transaksi',
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogDetailTransaction extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  DialogDetailTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      elevation: 0.5,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(32.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Detail Transaksi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      UniconsLine.times_circle,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Obx(
                  () => ListTile(
                    title: Text(
                      'Kode Transaksi : ${mTransactionCtl.codeTrans.value}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp. ',
                        decimalDigits: 0,
                      ).format(
                        mTransactionCtl.totalPayTransDetail.value,
                      ),
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder(
                init: mTransactionCtl,
                builder: (ctl) {
                  return ListView.builder(
                    itemCount: mTransactionCtl.listDetailTransDialog.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                mTransactionCtl
                                    .listDetailTransDialog[index].productName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Kode Produk : ${mTransactionCtl.listDetailTransDialog[index].idDocument}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: mTransactionCtl
                                    .listDetailTransDialog[index].variant!
                                    .map(
                                      (val) => ListTile(
                                        title: Text(
                                          'Varian : ${val['variantName']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        trailing: Text(
                                          'Jumlah Beli : ${val['totalBuy']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogPdfReport extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  DialogPdfReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      elevation: 0.5,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(32.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Buat Laporan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      UniconsLine.times_circle,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                  selectedDayHighlightColor: primaryColor,
                ),
                onValueChanged: (dates) {
                  mTransactionCtl.datePickRangeTrans = dates;
                },
                initialValue: mTransactionCtl.initRangeDatePicker,
              ),
              Obx(
                () => Text(
                  mTransactionCtl.errorMessageReport.value,
                  style: const TextStyle(fontSize: 14, color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () {
                  if (mTransactionCtl.isLoadingReportPdf.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: primaryColor,
                        size: 50,
                      ),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      mTransactionCtl.generatePdfTransaction();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      elevation: 0.5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      'Cetak Laporan',
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormProductTransaction extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  int indexProduct;

  FormProductTransaction({
    Key? key,
    required this.indexProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              mTransactionCtl
                  .listProductForm[indexProduct]['product'].productName,
              style: const TextStyle(fontSize: 13),
            ),
            subtitle: Text(
              NumberFormat.currency(
                locale: 'id',
                symbol: 'Rp. ',
                decimalDigits: 0,
              ).format(
                mTransactionCtl.listProductForm[indexProduct]['product'].price,
              ),
              style: const TextStyle(fontSize: 11),
            ),
          ),

          Row(
            children: [
              Flexible(
                child: DropdownSearch<VariantProductModel>(
                  items: mTransactionCtl.listProductForm[indexProduct]
                      ['variantProduct'],
                  compareFn: (i, s) => i.isEqual(s),
                  itemAsString: (VariantProductModel variant) =>
                      variant.variantAsString(),
                  onChanged: (VariantProductModel? value) {
                    mTransactionCtl.onSelectedVariant = value;
                  },
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    fit: FlexFit.loose,
                    menuProps: const MenuProps(
                      backgroundColor: Colors.transparent,
                      elevation: 0.5,
                    ),
                    containerBuilder: (ctx, popupWidget) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Flexible(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: popupWidget,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  dropdownDecoratorProps: GlobalStyles.dropdownDecoration(
                    'Pilih Varian Produk',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (mTransactionCtl.onSelectedVariant != null) {
                    mTransactionCtl.addFieldVariant(indexProduct);
                  }
                },
                icon: const Icon(
                  UniconsLine.plus_circle,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          // Variant Field
          ListView.builder(
            itemCount: mTransactionCtl
                .listProductForm[indexProduct]['variantSelected'].length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => FormVariantTransaction(
                indexProduct: indexProduct, indexVariant: index),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  mTransactionCtl.listProductForm.removeAt(indexProduct);
                  mTransactionCtl.updateTotalPay();
                  mTransactionCtl.update();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0.5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  'Hapus Produk',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FormVariantTransaction extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  int indexProduct;
  int indexVariant;
  FormVariantTransaction({
    required this.indexProduct,
    required this.indexVariant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    VariantProductModel variant = mTransactionCtl.listProductForm[indexProduct]
        ['variantSelected'][indexVariant]['variant'];

    final totalBuy = mTransactionCtl.listProductForm[indexProduct]
        ['variantSelected'][indexVariant]['totalBuy'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${variant.color}|${variant.size}',
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (totalBuy >= variant.stock) {
                    return;
                  }

                  mTransactionCtl.listProductForm[indexProduct]
                      ['variantSelected'][indexVariant]['totalBuy']++;

                  mTransactionCtl.updateTotalPay();
                  mTransactionCtl.update();
                },
                icon: const Icon(
                  UniconsLine.plus_circle,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: 20,
                child: Text(
                  mTransactionCtl.listProductForm[indexProduct]
                          ['variantSelected'][indexVariant]['totalBuy']
                      .toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (totalBuy <= 1) {
                    mTransactionCtl.listProductForm[indexProduct]
                            ['variantSelected']
                        .removeAt(indexVariant);
                    mTransactionCtl.update();
                    return;
                  }

                  mTransactionCtl.listProductForm[indexProduct]
                      ['variantSelected'][indexVariant]['totalBuy']--;
                  mTransactionCtl.updateTotalPay();
                  mTransactionCtl.update();
                },
                icon: const Icon(
                  UniconsLine.minus_circle,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionTable extends StatelessWidget {
  double screenSize;
  final mTransactionCtl = Get.find<ManageTransactionController>();

  TransactionTable({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GetBuilder(
            init: mTransactionCtl,
            builder: (_) {
              if (mTransactionCtl.isLoadingTableData.value) {
                return const ShimmerTransactionTable();
              }

              if (mTransactionCtl.listDataTable.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Yahhh, Belum ada satupun transaksi nih :('),
                  ),
                );
              }

              return Scrollbar(
                controller: mTransactionCtl.scrollHorizontalTable,
                child: SingleChildScrollView(
                  controller: mTransactionCtl.scrollHorizontalTable,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowHeight: 90,
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text('Nomor'),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text('Kode Transaksi'),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text('Total Pembayaran'),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text('Aksi'),
                          ),
                        ),
                      )
                    ],
                    rows: mTransactionCtl.listDataTable
                        .asMap()
                        .map(
                          (index, value) => MapEntry(
                            index,
                            DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth / 7,
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth / 4,
                                    child: Center(
                                      child: SelectableText(
                                        value.idDocument!,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth / 5,
                                    child: Center(
                                      child: Text(
                                        NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0,
                                        ).format(value.totalPay),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: screenSize > 450
                                        ? constraints.maxWidth / 4
                                        : constraints.maxWidth / 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            mTransactionCtl
                                                .setDialogDetailTransaction(
                                              value,
                                            );
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DialogDetailTransaction(),
                                            );
                                          },
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: const BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: const Icon(
                                              UniconsLine.eye,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(32),
                                              title: 'Hapus Transaksi',
                                              middleText:
                                                  'Apakah kamu yakin ingin menghapus transaksi ini ?',
                                              textConfirm: 'Ya',
                                              textCancel: 'Tidak',
                                              buttonColor: primaryColor,
                                              confirmTextColor: Colors.white,
                                              cancelTextColor: primaryColor,
                                              onConfirm: () {
                                                mTransactionCtl
                                                    .deleteTransaction(
                                                        value.idDocument!);
                                              },
                                              onCancel: () => Get.back(),
                                            );
                                          },
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: const BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: const Icon(
                                              UniconsLine.trash_alt,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ShimmerTransactionTable extends StatelessWidget {
  const ShimmerTransactionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(
        label: Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade600,
            highlightColor: Colors.grey.shade200,
            child: const Text('Nomor'),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade600,
            highlightColor: Colors.grey.shade200,
            child: const Text('Kode Transaksi'),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade600,
            highlightColor: Colors.grey.shade200,
            child: const Text('Total Pembayaran'),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade600,
            highlightColor: Colors.grey.shade200,
            child: const Text('Aksi'),
          ),
        ),
      )
    ], rows: const []);
  }
}
