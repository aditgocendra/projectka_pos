import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/home_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/styles.dart';
import 'package:projectka_pos/services/local/pdf_services.dart';
import 'package:unicons/unicons.dart';

class ManageTransaction extends StatelessWidget {
  const ManageTransaction({Key? key}) : super(key: key);

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
                    PdfServices.buildPdf(false);
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
                    showDialog(
                      context: context,
                      builder: (context) => DialogFormTransaction(),
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
                          'Tambah Transaksi',
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
            const DataTableTransaction(),
          ],
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
                      color: ColorConstant.primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant.primaryColor),
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
                      color: ColorConstant.primaryColor,
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
                  border: Border.all(color: ColorConstant.primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: const [
                    ListTile(
                      title: Text(
                        'Bunga Flamel',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Rp. 350.000',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        '3 Unit',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        '3 Seconds Bundle Transctip',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Rp. 320.000',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        '6 Unit',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                      color: ColorConstant.primaryColor,
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
                        cursorColor: ColorConstant.primaryColor,
                        decoration:
                            GlobalStyles.formInputDecoration('Kode Produk'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {
                      controller.countProductTransaction.value++;
                      final productSelect = {
                        'product': 'Bunga Flamel',
                        'price': 50000,
                        'total': 1.obs,
                      };
                      controller.listProductSelect.add(productSelect);
                    },
                    icon: const Icon(
                      UniconsLine.plus_circle,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ],
              ),
              // Product
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(
                  () {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.countProductTransaction.value,
                      itemBuilder: (context, index) => ProductItem(
                        index: index,
                      ),
                    );
                  },
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
                        color: ColorConstant.primaryColor,
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

class ProductItem extends StatelessWidget {
  final controller = Get.find<HomeController>();
  int index;
  ProductItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text(
        'Bunga Flamel',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        'Rp.30.000',
        style: TextStyle(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (controller.listProductSelect[index]['total'].value > 1) {
                controller.listProductSelect[index]['total'].value--;
              } else {
                controller.countProductTransaction.value--;
                controller.listProductSelect.removeAt(index);
              }
            },
            icon: const Icon(
              UniconsLine.minus_circle,
              color: ColorConstant.primaryColor,
            ),
          ),
          Obx(
            () => Text(
              controller.listProductSelect[index]['total'].value.toString(),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.listProductSelect[index]['total'].value++;
            },
            icon: const Icon(
              UniconsLine.plus_circle,
              color: ColorConstant.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DataTableTransaction extends StatelessWidget {
  const DataTableTransaction({
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
                    'Kode Transaksi',
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
                    'Total Pembayaran',
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
                    width: 120,
                    child: Center(
                      child: Text(
                        '1',
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  SizedBox(
                    width: 320,
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
                    width: 320,
                    child: Center(
                      child: Text(
                        'Rp. 300.000',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 350,
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
                              color: Colors.black87,
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
