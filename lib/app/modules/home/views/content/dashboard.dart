import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/dashboard_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/string.util.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeadDashboard(
              consWidth: constraints.maxWidth,
            ),
            const SizedBox(
              height: 16,
            ),
            LastTransaction(widthLayout: constraints.maxWidth),
          ],
        );
      },
    );
  }
}

class HeadDashboard extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  double consWidth;
  HeadDashboard({super.key, required this.consWidth});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: dashboardController,
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: consWidth > 668 ? 3 : 1,
            childAspectRatio:
                consWidth > 668 ? consWidth / 285 : consWidth / 90,
            crossAxisSpacing: 16,
            mainAxisSpacing: 8,
          ),
          itemCount: dashboardController.listHeadDashboard.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          dashboardController.listHeadDashboard[index]['icon'],
                          size: 28,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          dashboardController.listHeadDashboard[index]['title'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                    Text(
                      dashboardController.listHeadDashboard[index]['value']
                          .toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class LastTransaction extends StatelessWidget {
  double widthLayout;
  final dashboardController = Get.find<DashboardController>();

  LastTransaction({
    Key? key,
    required this.widthLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: ColorConstant.primaryColor,
        ),
        child: GetBuilder(
          init: dashboardController,
          builder: (_) {
            if (dashboardController.isLoadingLastTransaction.value) {
              return const ShimmerLastTransaction();
            }

            if (dashboardController.listLastTransaction.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Yahhh, Belum ada satupun transaksi nih :('),
                ),
              );
            }

            return Scrollbar(
              controller: dashboardController.scrollHorizontalTable,
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: dashboardController.scrollHorizontalTable,
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
                            'Tanggal Transaksi',
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
                  ],
                  rows: dashboardController.listLastTransaction
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: widthLayout / 10,
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: widthLayout / 4,
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
                                  width: widthLayout / 4,
                                  child: Center(
                                    child: Text(
                                      StringUtil.dMMMyFormat(
                                        value.createdAt.toDate(),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: widthLayout / 4.6,
                                  child: Center(
                                    child: Text(
                                      StringUtil.rupiahFormat(value.totalPay),
                                      textAlign: TextAlign.center,
                                    ),
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
      ),
    );
  }
}

class ShimmerLastTransaction extends StatelessWidget {
  const ShimmerLastTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: ColorConstant.primaryColor,
        ),
        child: DataTable(
          dataRowHeight: 80,
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
                    child: const Text('Kode Transaksi'),
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
                    child: const Text('Tanggal Transaksi'),
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
                    child: const Text('Total Pembayaran'),
                  ),
                ),
              ),
            ),
          ],
          rows: const [],
        ),
      ),
    );
  }
}
