import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_product_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/dialog.util.dart';
import 'package:projectka_pos/core/utils/styles.dart';
import 'package:projectka_pos/services/local/pdf_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageProduct extends StatelessWidget {
  final mProductController = Get.find<ManageProductController>();
  ManageProduct({Key? key}) : super(key: key);

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
            DataTableProduct(),
          ],
        ),
      ),
    );
  }
}

class DialogFormProduct extends StatelessWidget {
  final mProductController = Get.find<ManageProductController>();
  String titleForm;
  bool action;

  String? codeProduct;
  String? nameProduct;
  int? price;
  int? stock;

  DialogFormProduct({
    Key? key,
    required this.titleForm,
    required this.action,
    this.codeProduct,
    this.nameProduct,
    this.price,
    this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mProductController.resetEditingCtl();
    if (action) {
      mProductController.nameProductTec.text = nameProduct!;
      mProductController.priceTec.text = price.toString();
      mProductController.codeProductTec.text = codeProduct!;
      mProductController.stockProductTec.text = stock.toString();
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
                  controller: mProductController.codeProductTec,
                  enabled: action ? false : true,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: ColorConstant.primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Kode Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: mProductController.nameProductTec,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: ColorConstant.primaryColor,
                  decoration: GlobalStyles.formInputDecoration('Nama Produk'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: mProductController.priceTec,
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
                  controller: mProductController.stockProductTec,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: ColorConstant.primaryColor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: GlobalStyles.formInputDecoration('Stok Produk'),
                ),
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
    );
  }
}

class DataTableProduct extends StatelessWidget {
  final mProductController = Get.find<ManageProductController>();
  DataTableProduct({
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
        init: mProductController,
        builder: (_) {
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
            child: SingleChildScrollView(
              controller: mProductController.scrollHorizontalTable,
              scrollDirection: Axis.horizontal,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: ColorConstant.primaryColor),
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
                            'Terjual',
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
                  rows: mProductController.listProduct
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 25,
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 11.3,
                                  child: Center(
                                    child: Text(
                                      value.idDocument!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 10,
                                  child: Center(
                                    child: Text(
                                      value.productName,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 15,
                                  child: Center(
                                    child: Text(
                                      value.price.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 15,
                                  child: Center(
                                    child: Text(
                                      '${value.stock} Unit',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 15,
                                  child: Center(
                                    child: Text(
                                      '${value.sold} Unit',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth / 15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DialogFormProduct(
                                                titleForm: 'Ubah Produk',
                                                action: true,
                                                codeProduct: value.idDocument,
                                                nameProduct: value.productName,
                                                price: value.price,
                                                stock: value.stock,
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
                                              mProductController
                                                  .deleteDataProduct(
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
            ),
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
              child: const Text('Kode Produk'),
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
              child: const Text('Produk Terjual'),
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
