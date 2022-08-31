import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/home_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/styles.dart';
import 'package:unicons/unicons.dart';

class ManageUser extends StatelessWidget {
  const ManageUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
            const UserTable(),
          ],
        ),
      ),
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
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    decoration:
                        GlobalStyles.formInputDecoration('Nama Pengguna'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    obscureText: false,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
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

class UserTable extends StatelessWidget {
  const UserTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
          rows: [
            DataRow(
              cells: [
                const DataCell(
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: Text(
                        '1',
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 260,
                    child: Center(
                      child: Text(
                        'Aditya Gocendra',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 260,
                    child: Center(
                      child: Text(
                        'gocendra@ark.com',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 260,
                    child: Center(
                      child: Text(
                        'Kasir',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 260,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            Get.defaultDialog(
                              contentPadding: const EdgeInsets.all(32),
                              title: 'Hapus Produk',
                              middleText:
                                  'Apakah kamu yakin ingin menghapus produk ini ?',
                              textConfirm: 'Ya',
                              textCancel: 'Tidak',
                              buttonColor: Colors.black87,
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.black87,
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
          ],
        ),
      ),
    );
  }
}
