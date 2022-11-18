import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/utils/styles.dart';
import 'package:kelvin_project/app/models/category.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_product_controller.dart';
import 'package:kelvin_project/services/local/pdf_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageProduct extends StatelessWidget {
  ManageProduct({Key? key}) : super(key: key);
  final mProductController = Get.find<ManageProductController>();

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
                            if (mProductController.listProduct.isEmpty) {
                              return;
                            }
                            PdfService.buildPdf(
                                true, mProductController.listProduct, '');
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
                            if (mProductController.categoryData.isEmpty) {
                              Get.defaultDialog(
                                contentPadding: const EdgeInsets.all(32),
                                title: 'Kategori Kosong',
                                middleText:
                                    'Yahh kamu belum bisa nambahin produk nih, Tambahin kategori dulu yaa :)',
                                textConfirm: 'Ok',
                                buttonColor: primaryColor,
                                confirmTextColor: Colors.white,
                                onConfirm: () => Get.back(),
                              );
                              return;
                            }
                            mProductController.resetEditingCtl();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DialogFormProduct(
                                  titleForm: 'Tambah Produk',
                                  action: false,
                                );
                              },
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
                        if (mProductController.listProduct.isEmpty) {
                          return;
                        }
                        PdfService.buildPdf(
                            true, mProductController.listProduct, '');
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
                        mProductController.resetEditingCtl();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogFormProduct(
                              titleForm: 'Tambah Produk',
                              action: false,
                            );
                          },
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
  // action ? edit product : add product
  final mProductController = Get.find<ManageProductController>();
  String titleForm;
  bool action;

  String? codeProduct;
  String? nameProduct;
  int? price;

  DialogFormProduct({
    Key? key,
    required this.titleForm,
    required this.action,
    this.codeProduct,
    this.nameProduct,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (action) {
      mProductController.nameProductTec.text = nameProduct!;
      mProductController.priceTec.text = price.toString();
      mProductController.codeProductTec.text = codeProduct!;

      for (var i = 0; i < mProductController.listVariantProduct.length; i++) {
        if (i > 0) {
          mProductController.addFormVariant();
        }

        mProductController.listVariantFormCtl[i]['colorCtl'].text =
            mProductController.listVariantProduct[i].color;

        mProductController.listVariantFormCtl[i]['stockCtl'].text =
            mProductController.listVariantProduct[i].stock.toString();

        mProductController.listVariantFormCtl[i]['sizeSelected'] =
            mProductController.listVariantProduct[i].size;
      }
    }

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  controller: mProductController.codeProductTec,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 4,
                  readOnly: action ? true : false,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Kode Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: mProductController.nameProductTec,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Nama Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: mProductController.priceTec,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: primaryColor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: GlobalStyles.formInputDecoration('Harga'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GetBuilder(
                  init: mProductController,
                  builder: (_) {
                    return DropdownSearch<CategoryModel>(
                      items: mProductController.categoryData,
                      compareFn: (i, s) => i.isEqual(s),
                      itemAsString: (CategoryModel ctg) => ctg.ctgAsString(),
                      onChanged: (CategoryModel? value) {
                        mProductController.idCategorySelected =
                            value!.idDocument;
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
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Text(
                  mProductController.errFormMessage.value,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.redAccent),
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
                    onPressed: () {
                      mProductController.addFormVariant();
                      mProductController.update();
                    },
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
              GetBuilder(
                init: mProductController,
                builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mProductController.listVariantFormCtl.length,
                    itemBuilder: (context, index) => FormVariantProduct(
                      index: index,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!action) {
                    // Check Code Product
                    final codeProductIsAvailable =
                        await mProductController.checkCodeProduct(
                      mProductController.codeProductTec.text,
                    );

                    if (codeProductIsAvailable) {
                      mProductController.errFormMessage.value =
                          'Kode Produk Telah Tersedia';

                      return;
                    }
                  }
                  mProductController.setProduct();
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
  final mProductController = Get.find<ManageProductController>();
  int index;
  FormVariantProduct({Key? key, required this.index}) : super(key: key);

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
            controller: mProductController.listVariantFormCtl[index]
                ['colorCtl'],
            style: const TextStyle(fontSize: 14),
            cursorColor: primaryColor,
            decoration: GlobalStyles.formInputDecoration('Warna'),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: mProductController.listVariantFormCtl[index]
                ['stockCtl'],
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
            items: const ['S', 'M', 'L', 'XL', 'XXL', 'ALL SIZE'],
            selectedItem: mProductController.listVariantFormCtl[index]
                ['sizeSelected'],
            onChanged: (String? value) {
              mProductController.listVariantFormCtl[index]['sizeSelected'] =
                  value;
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
              if (mProductController.listVariantFormCtl.length <= 1) {
                return;
              }
              mProductController.removeFormVariant(index);
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

class DialogVariantProduct extends StatelessWidget {
  ProductModel product;
  final mProductController = Get.find<ManageProductController>();

  DialogVariantProduct({
    required this.product,
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
                  children: [
                    const Expanded(
                      child: Text(
                        'Kode Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.idDocument!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Nama Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.productName,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Harga Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp. ',
                          decimalDigits: 0,
                        ).format(product.price),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Kategori Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: GetBuilder(
                        init: mProductController,
                        builder: (ctl) => Text(
                          mProductController.ctgDetailProduct != null
                              ? mProductController.ctgDetailProduct!.name
                              : 'Kategori Tidak Ditemukan',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Stok Produk',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${product.allStock} Unit',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Produk Terjual',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${product.sold} Unit',
                        style: const TextStyle(fontSize: 14),
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
              GetBuilder(
                init: mProductController,
                builder: (ctl) {
                  return Column(
                    children: mProductController.listVariantProduct
                        .map(
                          (val) => Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                'Warna ${val.color}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Text(
                                'Ukuran ${val.size}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Text(
                                '${val.stock} Unit',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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

class ProductTable extends StatelessWidget {
  double screenSize;

  ProductTable({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final mProductController = Get.find<ManageProductController>();

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
            init: mProductController,
            builder: (ctl) {
              if (mProductController.isLoading.value) {
                return const ShimmerTableProductLoading();
              }

              if (mProductController.listProduct.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Yahhh, Belum ada satupun produk nih :('),
                  ),
                );
              }

              return Scrollbar(
                controller: mProductController.scrollHorizontalTable,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: mProductController.scrollHorizontalTable,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowHeight: 80,
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text('Kode Produk'),
                          ),
                        ),
                      ),
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
                    rows: mProductController.listProduct.map(
                      (val) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: constraints.maxWidth / 8,
                                child: Center(
                                  child: SelectableText(val.idDocument!),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: constraints.maxWidth / 5,
                                child: Center(
                                  child: Text(val.productName),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: constraints.maxWidth / 7,
                                child: Center(
                                  child: Text(
                                    NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0,
                                    ).format(val.price),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: constraints.maxWidth / 10,
                                child: Center(
                                  child: Text(val.allStock.toString()),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenSize > 630
                                    ? constraints.maxWidth / 4.39
                                    : constraints.maxWidth / 1.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        mProductController.getCategoryProduct(
                                          val.idCategory,
                                        );

                                        mProductController.readVariantProduct(
                                          val.idDocument!,
                                        );

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogVariantProduct(
                                              product: val,
                                            );
                                          },
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
                                      onTap: () async {
                                        if (mProductController
                                            .categoryData.isEmpty) {
                                          Get.defaultDialog(
                                            contentPadding:
                                                const EdgeInsets.all(32),
                                            title: 'Kategori Kosong',
                                            middleText:
                                                'Yahh kamu belum bisa nambahin produk nih, Tambahin kategori dulu yaa :)',
                                            textConfirm: 'Ok',
                                            buttonColor: primaryColor,
                                            confirmTextColor: Colors.white,
                                            onConfirm: () => Get.back(),
                                          );
                                          return;
                                        }

                                        mProductController.resetEditingCtl();

                                        await mProductController
                                            .readVariantProduct(
                                          val.idDocument!,
                                        );

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogFormProduct(
                                              titleForm: 'Ubah Produk',
                                              action: true,
                                              codeProduct: val.idDocument,
                                              nameProduct: val.productName,
                                              price: val.price,
                                            );
                                          },
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
                                          contentPadding:
                                              const EdgeInsets.all(32),
                                          title: 'Hapus Produk',
                                          middleText:
                                              'Apakah kamu yakin ingin menghapus produk ini ?',
                                          textConfirm: 'Ya',
                                          textCancel: 'Tidak',
                                          buttonColor: primaryColor,
                                          confirmTextColor: Colors.white,
                                          cancelTextColor: primaryColor,
                                          onConfirm: () {
                                            mProductController
                                                .deleteDataProduct(
                                                    val.idDocument!);
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
                        );
                      },
                    ).toList(),
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

class ShimmerTableProductLoading extends StatelessWidget {
  const ShimmerTableProductLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
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
              child: const Text('Produk'),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade600,
              highlightColor: Colors.grey.shade200,
              child: const Text('Harga'),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade600,
              highlightColor: Colors.grey.shade200,
              child: const Text('Stok Produk'),
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
      ],
      rows: const [],
    );
  }
}
