import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/globals/styles.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
import 'package:kelvin_project/services/local/pdf_services.dart';
import 'package:unicons/unicons.dart';

class ManageProduct extends StatelessWidget {
  const ManageProduct({Key? key}) : super(key: key);

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
          child: screenSize > 700
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pengelolaan Produk',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            PdfService.buildPdf(true);
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
                                  'Cetak Laporan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogFormProduct(
                                titleForm: 'Tambah Produk',
                              ),
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
                                  'Tambah Produk',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Pengelolaan Produk',
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
                        PdfService.buildPdf(true);
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
                              'Cetak Laporan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
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
                          builder: (context) => DialogFormProduct(
                            titleForm: 'Tambah Produk',
                          ),
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
                              'Tambah Produk',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
        ProductTable(screenSize: screenSize),
      ],
    );
  }
}

class DialogFormProduct extends StatelessWidget {
  final controller = Get.find<HomeController>();
  String titleForm;

  DialogFormProduct({Key? key, required this.titleForm}) : super(key: key);

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
        padding: const EdgeInsets.all(32),
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
                  Text(
                    titleForm,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  cursorColor: primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Kode Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  cursorColor: primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Nama Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  cursorColor: primaryColor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: GlobalStyles.formInputDecoration('Harga'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownSearch<String>(
                  items: const ['Atasan', 'Bawahan'],
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
                    'Kategori Produk',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Varian Produk',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.countVariantForm.value++,
                    icon: const Icon(
                      UniconsLine.plus_circle,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // Variant Product
              Obx(
                () {
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.countVariantForm.value,
                    itemBuilder: (context, index) => FormVariantProduct(),
                  );
                },
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

class FormVariantProduct extends StatelessWidget {
  final controller = Get.find<HomeController>();

  FormVariantProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(fontSize: 14),
            cursorColor: primaryColor,
            decoration: GlobalStyles.formInputDecoration('Warna'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            style: const TextStyle(fontSize: 14),
            cursorColor: primaryColor,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: GlobalStyles.formInputDecoration('Stok'),
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownSearch<String>(
            items: const ['S', 'M', 'L', 'XL', 'XXL'],
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
                      height: 16,
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
              'Ukuran',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.countVariantForm.value <= 1) {
                return;
              }
              controller.countVariantForm.value--;
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
              'Hapus Varian',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

class DialogDetailProduct extends StatelessWidget {
  const DialogDetailProduct({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Detail Produk',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Text(
                        'Kode Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'B02152F23',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Text(
                        'Nama Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '3 Sezonds Bundle Item',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Text(
                        'Harga Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Rp. 50.000',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Text(
                        'Kategori Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Baju Atasan',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Text(
                        'Stok Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '236 Unit',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Varian Produk',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: const ListTile(
                      title: Text(
                        'Merah',
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        'XL',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        '100 Unit',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: const ListTile(
                      title: Text(
                        'Pink',
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        'L',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        '136 Unit',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  final screenSize;

  const ProductTable({
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
            child: SingleChildScrollView(
              child: DataTable(
                dataRowHeight: 80,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Produk'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Harga'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Kategori'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Stok Produk'),
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
                          width: constraints.maxWidth / 6,
                          child: const Center(
                            child: Text('Teasdaasdasdasdas  asdasdas sdasxt'),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: constraints.maxWidth / 6,
                          child: const Center(
                            child: Text('Rp. 500.000'),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: constraints.maxWidth / 6,
                          child: const Center(
                            child: Text('Baju Atasan'),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: constraints.maxWidth / 8,
                          child: const Center(
                            child: Text('1'),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: screenSize > 850
                              ? constraints.maxWidth / 6
                              : constraints.maxWidth / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DialogDetailProduct(),
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
                                  showDialog(
                                    context: context,
                                    builder: (context) => DialogFormProduct(
                                      titleForm: 'Ubah Produk',
                                    ),
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
                                    UniconsLine.edit,
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
                                    title: 'Hapus Produk',
                                    middleText:
                                        'Apakah kamu yakin ingin menghapus produk ini ?',
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
