import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/utils/styles.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_category_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageCategory extends StatelessWidget {
  ManageCategory({Key? key}) : super(key: key);
  final mCtgController = Get.find<ManageCategoryController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    mCtgController.refreshData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: screenSize > 550
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pengelolaan Kategori',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogFormCategory(
                            titleForm: 'Tambah Kategori',
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
                              'Tambah Kategori',
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
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pengelolaan Kategori',
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
                        showDialog(
                          context: context,
                          builder: (context) => DialogFormCategory(
                            titleForm: 'Tambah Kategori',
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
                              'Tambah Kategori',
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
        CategoryTable()
      ],
    );
  }
}

// ignore: must_be_immutable
class DialogFormCategory extends StatelessWidget {
  String titleForm;
  String? idDocument;
  String? name;
  DialogFormCategory({
    Key? key,
    required this.titleForm,
    this.idDocument,
    this.name,
  }) : super(key: key);

  final mCtgController = Get.find<ManageCategoryController>();
  @override
  Widget build(BuildContext context) {
    if (name != null) {
      mCtgController.nameTec.text = name!;
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
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
                    controller: mCtgController.nameTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration:
                        GlobalStyles.formInputDecoration('Nama Kategori'),
                  ),
                ),
                Obx(
                  () => Text(
                    mCtgController.errorMessageForm.value,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (name == null) {
                      mCtgController.createCategory();
                    } else {
                      mCtgController.updateCategory(idDocument!);
                    }
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
      ),
    );
  }
}

class CategoryTable extends StatelessWidget {
  CategoryTable({
    Key? key,
  }) : super(key: key);
  final mCtgController = Get.find<ManageCategoryController>();

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
            init: mCtgController,
            builder: (ctl) {
              if (mCtgController.isLoading.value) {
                return const ShimmerTableCategoryLoading();
              }

              if (mCtgController.listCategory.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Yahhh, Belum ada satupun kategori nih :('),
                  ),
                );
              }

              return Scrollbar(
                controller: mCtgController.scrollHorizontalTable,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: mCtgController.scrollHorizontalTable,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: true,
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
                            child: Text('Nama Kategori'),
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
                    rows: mCtgController.listCategory
                        .asMap()
                        .map(
                          (index, value) => MapEntry(
                            index,
                            DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth / 7.7,
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth / 2,
                                    child: Center(
                                      child: Text(
                                        value.name,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: constraints.maxWidth / 4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DialogFormCategory(
                                                titleForm: 'Ubah Kategori',
                                                name: value.name,
                                                idDocument: value.idDocument,
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
                                              contentPadding:
                                                  const EdgeInsets.all(32),
                                              title: 'Hapus Kategori',
                                              middleText:
                                                  'Apakah kamu yakin ingin menghapus kategori ini ?',
                                              textConfirm: 'Ya',
                                              textCancel: 'Tidak',
                                              buttonColor: primaryColor,
                                              confirmTextColor: Colors.white,
                                              cancelTextColor: primaryColor,
                                              onConfirm: () =>
                                                  mCtgController.deleteCategory(
                                                      value.idDocument!),
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

class ShimmerTableCategoryLoading extends StatelessWidget {
  const ShimmerTableCategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Expanded(
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade600,
                highlightColor: Colors.grey.shade200,
                child: const Text('Nomor'),
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade600,
                highlightColor: Colors.grey.shade200,
                child: const Text('Nama Kategori'),
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade600,
                highlightColor: Colors.grey.shade200,
                child: const Text('Aksi'),
              ),
            ),
          ),
        )
      ],
      rows: const [],
    );
  }
}
