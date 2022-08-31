import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/home_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/dialog.util.dart';
import 'package:projectka_pos/core/utils/styles.dart';
import 'package:projectka_pos/services/local/pdf_services.dart';
import 'package:unicons/unicons.dart';

class ManageProduct extends StatelessWidget {
  const ManageProduct({Key? key}) : super(key: key);

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
                    PdfServices.buildPdf(true);
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
                    DialogUtil.showDialogAddProduct(context);
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
            ),
            const SizedBox(
              height: 16,
            ),
            const DataTableProduct(),
          ],
        ),
      ),
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
                  decoration: GlobalStyles.formInputDecoration('Kode Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  cursorColor: ColorConstant.primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Nama Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  cursorColor: ColorConstant.primaryColor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: GlobalStyles.formInputDecoration('Harga'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  cursorColor: ColorConstant.primaryColor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: GlobalStyles.formInputDecoration('Stok Produk'),
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
    );
  }
}

class DataTableProduct extends StatelessWidget {
  const DataTableProduct({
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
                    'Kode Produk',
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
                    'Nama Produk',
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
                    'Harga Produk',
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
                    'Stok Produk',
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
                    width: 60,
                    child: Center(
                      child: Text(
                        '1',
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        'TR-MR-2022-RR-NJASDNJASBD',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        'Bunga bisa dimakan',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        'Rp. 300.000',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 180,
                    child: Center(
                      child: Text(
                        '5 Unit',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
