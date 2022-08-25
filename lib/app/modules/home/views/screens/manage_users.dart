import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/globals/styles.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
import 'package:unicons/unicons.dart';

class ManageUsers extends StatelessWidget {
  const ManageUsers({Key? key}) : super(key: key);

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
          child: screenSize > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pengelolaan Pengguna',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogFormUsers(
                            titleForm: 'Tambah Pengguna',
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
                              'Tambah Pengguna',
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
                      'Pengelolaan Pengguna',
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
                          builder: (context) => DialogFormUsers(
                            titleForm: 'Tambah Pengguna',
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
                              'Tambah Pengguna',
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
        UsersTable(
          screenSize: screenSize,
        )
      ],
    );
  }
}

class DialogFormUsers extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final titleForm;

  DialogFormUsers({Key? key, required this.titleForm}) : super(key: key);

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
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration:
                        GlobalStyles.formInputDecoration('Nama Pengguna'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    obscureText: false,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    obscureText: false,
                    decoration: GlobalStyles.formInputDecoration(
                        'Konfirmasi Kata Sandi'),
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
      ),
    );
  }
}

class UsersTable extends StatelessWidget {
  final screenSize;

  const UsersTable({Key? key, required this.screenSize}) : super(key: key);

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
              dataRowHeight: 70,
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
                      child: Text('Email'),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Center(
                      child: Text('Nama Pengguna'),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Center(
                      child: Text('Peran Pengguna'),
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
                        width: constraints.maxWidth / 10,
                        child: const Center(
                          child: Text(
                            '1',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: constraints.maxWidth / 6,
                        child: const Center(
                          child: Text(
                            'blackmarket@gmail.com',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: constraints.maxWidth / 6,
                        child: const Center(
                          child: Text(
                            'Kevin Ngotak',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: constraints.maxWidth / 5,
                        child: const Center(
                          child: Text(
                            'Bandar',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: screenSize > 550
                            ? constraints.maxWidth / 5
                            : constraints.maxWidth / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogFormUsers(
                                    titleForm: 'Ubah Pengguna',
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
                                  title: 'Hapus Pengguna',
                                  middleText:
                                      'Apakah kamu yakin ingin menghapus pengguna ini ?',
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
      ),
    );
  }
}
