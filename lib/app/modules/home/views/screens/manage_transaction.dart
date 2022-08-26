import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/globals/styles.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
import 'package:kelvin_project/services/local/pdf_services.dart';
import 'package:unicons/unicons.dart';

class ManageTransaction extends StatelessWidget {
  const ManageTransaction({Key? key}) : super(key: key);

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
                            PdfService.buildPdf(false);
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
                        PdfService.buildPdf(false);
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
  final controller = Get.find<HomeController>();
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
                  IconButton(
                    onPressed: () => controller.addProductForm(),
                    icon: const Icon(
                      UniconsLine.plus_circle,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              // Form Product Transaction
              Obx(
                () => ListView.builder(
                  itemCount: controller.countProductTransactionForm.value,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => FormProductTransaction(
                    index: index,
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
                  children: const [
                    Text(
                      'Total Bayar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp. 240.000',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
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
                  'Simpan',
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
  const DialogDetailTransaction({Key? key}) : super(key: key);

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
                child: const ListTile(
                  title: Text(
                    'Kode Transaksi : TR-KL-2022-08-12-B023SJHFD',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    'Rp. 540.000',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        '3 Seconds Bundle Transctip',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Kode Produk : B023SJHFD',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        '3 Unit',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                        children: const [
                          ListTile(
                            title: Text(
                              'Warna : Biru',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                              'Ukuran : XL',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Warna : Merah',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                              'Ukuran : XL',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Warna : Ungu',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                              'Ukuran : XL',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormProductTransaction extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final index;

  FormProductTransaction({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
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
            title: const Text(
              '3 Seconds Bundle',
              style: TextStyle(fontSize: 13),
            ),
            subtitle: const Text(
              'Rp. 50.000',
              style: TextStyle(fontSize: 11),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    controller.listProductVariantTransactionForm[index].value++;
                  },
                  icon: const Icon(
                    UniconsLine.plus_circle,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (controller
                            .listProductVariantTransactionForm[index].value <=
                        1) {
                      return;
                    }
                    controller.listProductVariantTransactionForm[index].value--;
                  },
                  icon: const Icon(
                    UniconsLine.minus_circle,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () {
              return ListView.builder(
                itemCount:
                    controller.listProductVariantTransactionForm[index].value,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) => FormProductVariantTransaction(
                  index: index,
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => controller.removeProductForm(index),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
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
              Obx(
                () => Text(
                  'Jumlah : ${controller.listProductVariantTransactionForm[index].value}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FormProductVariantTransaction extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final index;

  FormProductVariantTransaction({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: DropdownSearch<String>(
        items: const ['Merah | XL', 'Pink | L'],
        onChanged: (String? value) {
          // controller.conditionSelected.value = value!;
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
    );
  }
}

class TransactionTable extends StatelessWidget {
  final screenSize;

  const TransactionTable({
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
            return SingleChildScrollView(
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
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: constraints.maxWidth / 7,
                          child: const Center(
                            child: Text(
                              '1',
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: constraints.maxWidth / 4,
                          child: const Center(
                            child: Text(
                              'TR-KL-2022-15-05-AT-BWEWDSGSDKLFE',
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: constraints.maxWidth / 5,
                          child: const Center(
                            child: Text(
                              'Rp. 540.000',
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: screenSize > 450
                              ? constraints.maxWidth / 4
                              : constraints.maxWidth / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DialogDetailTransaction(),
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
                                    contentPadding: const EdgeInsets.all(32),
                                    title: 'Hapus Transaksi',
                                    middleText:
                                        'Apakah kamu yakin ingin menghapus transaksi ini ?',
                                    textConfirm: 'Ya',
                                    textCancel: 'Tidak',
                                    buttonColor: primaryColor,
                                    confirmTextColor: Colors.white,
                                    cancelTextColor: primaryColor,
                                    onConfirm: () {
                                      Get.back();
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
                  )
                ],
              ),
            );
          },
        ));
  }
}
