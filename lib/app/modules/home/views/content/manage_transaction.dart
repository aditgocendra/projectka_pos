import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectka_pos/app/models/product.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/string.util.dart';
import 'package:projectka_pos/core/utils/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class ManageTransaction extends StatelessWidget {
  final mTransController = Get.find<ManageTransactionController>();
  ManageTransaction({Key? key}) : super(key: key);

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
                    mTransController.errorMessageReport.value = '';
                    showDialog(
                      context: context,
                      builder: (context) => DialogPdfReport(),
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
            DataTableTransaction(),
          ],
        ),
      ),
    );
  }
}

class DialogDetailTransaction extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  DialogDetailTransaction({Key? key}) : super(key: key);

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
                child: ListTile(
                  title: Text(
                    mTransactionCtl.codeTrans.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    StringUtil.rupiahFormat(
                      mTransactionCtl.totalPayTransDetail.value,
                    ),
                    style: const TextStyle(
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
                child: GetBuilder(
                  init: mTransactionCtl,
                  builder: (_) {
                    return Column(
                      children: mTransactionCtl.listDetailTransDialog
                          .map(
                            (val) => ListTile(
                              title: Text(
                                val.productName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                StringUtil.rupiahFormat(val.price),
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Text(
                                '${val.totalBuy} Unit',
                                style: const TextStyle(
                                  color: ColorConstant.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
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
  final mTransController = Get.find<ManageTransactionController>();

  DialogFormTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mTransController.resetFormProduct();
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
                        controller: mTransController.codeProductTec,
                        style: const TextStyle(fontSize: 14),
                        cursorColor: ColorConstant.primaryColor,
                        decoration:
                            GlobalStyles.formInputDecoration('Nama Produk'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {
                      mTransController.addProductForm();
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
                child: GetBuilder(
                  init: mTransController,
                  builder: (_) {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: mTransController.listProductForm.length,
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
                  children: [
                    const Text(
                      'Total Bayar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        StringUtil.rupiahFormat(
                          mTransController.totalPay.value,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Text(
                  mTransController.errorMessageForm.value,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  mTransController.createTransaction();
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

class DialogPdfReport extends StatelessWidget {
  final mTransactionCtl = Get.find<ManageTransactionController>();
  DialogPdfReport({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Buat Laporan',
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
              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                  selectedDayHighlightColor: ColorConstant.primaryColor,
                ),
                onValueChanged: (dates) {
                  mTransactionCtl.datePickRangeTrans = dates;
                },
                initialValue: mTransactionCtl.initRangeDatePicker,
              ),
              Obx(
                () => Text(
                  mTransactionCtl.errorMessageReport.value,
                  style: const TextStyle(fontSize: 14, color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () {
                  if (mTransactionCtl.isLoadingReportPdf.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: ColorConstant.primaryColor,
                        size: 50,
                      ),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      mTransactionCtl.generatePdfTransaction();
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
                      'Cetak Laporan',
                      style: TextStyle(fontSize: 14),
                    ),
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

class ProductItem extends StatelessWidget {
  final mTransController = Get.find<ManageTransactionController>();
  int index;
  ProductItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = mTransController.listProductForm[index]['product'];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        product.productName,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        product.price.toString(),
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              mTransController.removeValueProductForm(index);
            },
            icon: const Icon(
              UniconsLine.minus_circle,
              color: ColorConstant.primaryColor,
            ),
          ),
          Text(
            mTransController.listProductForm[index]['totalBuy'].toString(),
          ),
          IconButton(
            onPressed: () {
              mTransController.listProductForm[index]['totalBuy'] += 1;
              mTransController.updateTotalPay();
              mTransController.update();
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
  final mTransController = Get.find<ManageTransactionController>();
  DataTableTransaction({
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
        init: mTransController,
        builder: (_) {
          if (mTransController.isLoadingTableData.value) {
            return const ShimmerTransactionTable();
          }

          if (mTransController.listDataTable.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Yahhh, Belum ada satupun transaksi nih :('),
              ),
            );
          }

          return Scrollbar(
            controller: mTransController.scrollHorizontalCtl,
            child: SingleChildScrollView(
                controller: mTransController.scrollHorizontalCtl,
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
                    rows: mTransController.listDataTable
                        .asMap()
                        .map(
                          (index, value) => MapEntry(
                            index,
                            DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: screenWidth / 15,
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: screenWidth / 6,
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
                                    width: screenWidth / 6,
                                    child: Center(
                                      child: Text(
                                        StringUtil.rupiahFormat(value.totalPay),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: screenWidth / 5.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            mTransController
                                                .setDialogDetailTransaction(
                                                    value);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DialogDetailTransaction(),
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
                                              contentPadding:
                                                  const EdgeInsets.all(32),
                                              title: 'Hapus Transaksi',
                                              middleText:
                                                  'Apakah kamu yakin ingin menghapus transaksi ini ?',
                                              textConfirm: 'Ya',
                                              textCancel: 'Tidak',
                                              buttonColor: Colors.black87,
                                              confirmTextColor: Colors.white,
                                              cancelTextColor: Colors.black87,
                                              onConfirm: () {
                                                mTransController
                                                    .deleteTransaction(
                                                  value.idDocument!,
                                                );
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
                          ),
                        )
                        .values
                        .toList(),
                  ),
                )),
          );
        },
      ),
    );
  }
}

class ShimmerTransactionTable extends StatelessWidget {
  const ShimmerTransactionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(
        label: Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade600,
            highlightColor: Colors.grey.shade200,
            child: const Text('Nomor'),
          ),
        ),
      ),
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
            child: const Text('Total Pembayaran'),
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
    ], rows: const []);
  }
}
