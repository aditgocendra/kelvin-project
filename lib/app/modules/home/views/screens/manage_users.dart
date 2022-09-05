import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/globals/styles.dart';
import 'package:kelvin_project/app/models/users.dart';

import 'package:kelvin_project/app/modules/home/controllers/manage_users_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageUsers extends StatelessWidget {
  final mUsersController = Get.find<ManageUsersController>();
  ManageUsers({Key? key}) : super(key: key);

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
                          builder: (context) => DialogFormAddUsers(),
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
                          builder: (context) => DialogFormAddUsers(),
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

class DialogFormAddUsers extends StatelessWidget {
  final mUsersController = Get.find<ManageUsersController>();

  DialogFormAddUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mUsersController.errorMessageFormAdd.value = '';
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
                    const Text(
                      'Tambah Pengguna',
                      style: TextStyle(
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
                    controller: mUsersController.emailAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUsersController.usernameAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration:
                        GlobalStyles.formInputDecoration('Nama Pengguna'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownSearch<String>(
                    items: const ['Admin', 'Kasir'],
                    selectedItem: mUsersController.roleUserAdd,
                    onChanged: (String? value) {
                      mUsersController.roleUserAdd = value;
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
                      'Peran Pengguna',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUsersController.passAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUsersController.confPassAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration(
                        'Konfirmasi Kata Sandi'),
                  ),
                ),
                Obx(
                  () => Text(
                    mUsersController.errorMessageFormAdd.value,
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    mUsersController.createUserData();
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

class DialogFormEditUsers extends StatelessWidget {
  final mUsersController = Get.find<ManageUsersController>();
  UserModel user;
  DialogFormEditUsers({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mUsersController.emailEditTec.text = user.email;
    mUsersController.usernameEditTec.text = user.username;
    mUsersController.roleUserEdit = user.role;
    mUsersController.errorMessageFormEdit.value = '';

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
                    const Text(
                      'Ubah Pengguna',
                      style: TextStyle(
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
                    enabled: false,
                    controller: mUsersController.emailEditTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUsersController.usernameEditTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration:
                        GlobalStyles.formInputDecoration('Nama Pengguna'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownSearch<String>(
                    items: const ['Admin', 'Kasir'],
                    selectedItem: mUsersController.roleUserEdit,
                    onChanged: (String? value) {
                      mUsersController.roleUserEdit = value;
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
                      'Peran Pengguna',
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    mUsersController.errorMessageFormEdit.value,
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    mUsersController.editUserData(user);
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
                    'Simpan Perubahan',
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

class DialogFormResetPassword extends StatelessWidget {
  final mUsersController = Get.find<ManageUsersController>();
  UserModel user;
  DialogFormResetPassword({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mUsersController.errorMessageFormChangePass.value = '';
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
                    const Text(
                      'Atur Ulang Kata Sandi',
                      style: TextStyle(
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
                    controller: mUsersController.passEditTec,
                    obscureText: true,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration: GlobalStyles.formInputDecoration(
                      'Kata Sandi Baru',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUsersController.confPassEditTec,
                    obscureText: true,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration: GlobalStyles.formInputDecoration(
                      'Konfirmasi Kata Sandi Baru',
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    mUsersController.errorMessageFormChangePass.value,
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    mUsersController.changePassword(user);
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
                    'Simpan Perubahan',
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
  double screenSize;
  final mUsersController = Get.find<ManageUsersController>();
  UsersTable({Key? key, required this.screenSize}) : super(key: key);

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
            init: mUsersController,
            builder: (ctl) {
              if (mUsersController.isLoading.value) {
                return const ShimmerUserTable();
              }

              if (mUsersController.listUsers.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Yahhh, Belum ada satupun pengguna nih :('),
                  ),
                );
              }

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
                  rows: mUsersController.listUsers
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: constraints.maxWidth / 10,
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: constraints.maxWidth / 6,
                                  child: Center(
                                    child: Text(
                                      value.email,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: constraints.maxWidth / 6,
                                  child: Center(
                                    child: Text(
                                      value.username,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: constraints.maxWidth / 5,
                                  child: Center(
                                    child: Text(
                                      value.role,
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
                                            builder: (context) =>
                                                DialogFormEditUsers(
                                              user: value,
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
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DialogFormResetPassword(
                                              user: value,
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
                                            UniconsLine.key_skeleton,
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
                                          if (value.role == 'Super Admin') {
                                            Get.defaultDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(32),
                                              title: 'Super Admin',
                                              middleText:
                                                  'Akun ini tidak dapat dihapus',
                                              textConfirm: 'Ok',
                                              buttonColor: primaryColor,
                                              confirmTextColor: Colors.white,
                                              onConfirm: () {
                                                Get.back();
                                              },
                                            );
                                            return;
                                          }
                                          Get.defaultDialog(
                                            contentPadding:
                                                const EdgeInsets.all(32),
                                            title: 'Hapus Pengguna',
                                            middleText:
                                                'Apakah kamu yakin ingin menghapus pengguna ini ?',
                                            textConfirm: 'Ya',
                                            textCancel: 'Tidak',
                                            buttonColor: primaryColor,
                                            confirmTextColor: Colors.white,
                                            cancelTextColor: primaryColor,
                                            onConfirm: () {
                                              mUsersController.deleteUser(
                                                value.idDocument!,
                                              );
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
              );
            },
          );
        },
      ),
    );
  }
}

class ShimmerUserTable extends StatelessWidget {
  const ShimmerUserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
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
              child: const Text('Email'),
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
              child: const Text('Nama Pengguna'),
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
              child: const Text('Peran Pengguna'),
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
    ], rows: const []);
  }
}
