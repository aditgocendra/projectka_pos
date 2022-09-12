import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/models/users.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_user_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageUser extends StatelessWidget {
  final mUserController = Get.find<ManageUserController>();
  ManageUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogAddFormUser(),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black87,
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            UserTable(),
          ],
        ),
      ),
    );
  }
}

class DialogAddFormUser extends StatelessWidget {
  final mUserController = Get.find<ManageUserController>();

  DialogAddFormUser({Key? key}) : super(key: key);

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
                        color: ColorConstant.primaryColor,
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
                    controller: mUserController.emailAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUserController.usernameAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    decoration:
                        GlobalStyles.formInputDecoration('Nama Pengguna'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownSearch<String>(
                    items: const ['Admin', 'Kasir'],
                    selectedItem: mUserController.roleUserAdd,
                    onChanged: (String? value) {
                      mUserController.roleUserAdd = value;
                    },
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      fit: FlexFit.loose,
                      menuProps: const MenuProps(
                        backgroundColor: Colors.transparent,
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
                    controller: mUserController.passAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUserController.confPassAddTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration(
                      'Konfirmasi Kata Sandi',
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    mUserController.errorMessageFormAdd.value,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    mUserController.createUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
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

class DialogEditFormUser extends StatelessWidget {
  final mUsersController = Get.find<ManageUserController>();
  UserModel user;
  DialogEditFormUser({
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
                        color: ColorConstant.primaryColor,
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
                    cursorColor: ColorConstant.primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mUsersController.usernameEditTec,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
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
                    backgroundColor: ColorConstant.primaryColor,
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
  final mUsersController = Get.find<ManageUserController>();
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
                        color: ColorConstant.primaryColor,
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
                    cursorColor: ColorConstant.primaryColor,
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
                    cursorColor: ColorConstant.primaryColor,
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
                    print(user.idDocument);
                    mUsersController.changePassword(user);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstant.primaryColor,
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

class UserTable extends StatelessWidget {
  final mUserController = Get.find<ManageUserController>();
  UserTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          width: 1,
        ),
      ),
      child: GetBuilder(
        init: mUserController,
        builder: (_) {
          if (mUserController.isLoading.value) {
            return const ShimmerUserTable();
          }

          if (mUserController.listUsers.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Yahhh, Belum ada satupun pengguna nih :('),
              ),
            );
          }

          return Scrollbar(
            controller: mUserController.scrollHorizontalTable,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: mUserController.scrollHorizontalTable,
              child: DataTable(
                dataRowHeight: 80,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Nomor',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Nama Pengguna',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Peran',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Aksi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                rows: mUserController.listUsers
                    .asMap()
                    .map(
                      (index, value) => MapEntry(
                        index,
                        DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: screenWidth / 12.5,
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenWidth / 8,
                                child: Center(
                                  child: Text(
                                    value.username,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenWidth / 8,
                                child: Center(
                                  child: Text(
                                    value.email,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenWidth / 10.5,
                                child: Center(
                                  child: Text(
                                    value.role,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenWidth / 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              DialogEditFormUser(
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
                                          color: Colors.black87,
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
                                        print(value.idDocument);
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
                                          color: ColorConstant.primaryColor,
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
                                        Get.defaultDialog(
                                          contentPadding:
                                              const EdgeInsets.all(32),
                                          title: 'Hapus Produk',
                                          middleText:
                                              'Apakah kamu yakin ingin menghapus produk ini ?',
                                          textConfirm: 'Ya',
                                          textCancel: 'Tidak',
                                          buttonColor: Colors.black87,
                                          confirmTextColor: Colors.white,
                                          cancelTextColor: Colors.black87,
                                          onConfirm: () {
                                            mUserController.deleteUser(
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
                                          color: Colors.black87,
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
                            ),
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
