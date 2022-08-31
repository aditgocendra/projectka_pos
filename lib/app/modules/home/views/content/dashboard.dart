import 'package:flutter/material.dart';
import 'package:projectka_pos/core/constant/dashboard.constant.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 668 ? 3 : 1,
                childAspectRatio: constraints.maxWidth > 668
                    ? constraints.maxWidth / 285
                    : constraints.maxWidth / 90,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
              ),
              itemCount: DashboardConstant.headerCard.length,
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
                              DashboardConstant.headerCard[index]['icon'],
                              size: 28,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DashboardConstant.headerCard[index]['title'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                              ),
                            )
                          ],
                        ),
                        const Text(
                          '214',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CardLastTransaction(widthLayout: constraints.maxWidth),
          ],
        );
      },
    );
  }
}

class CardLastTransaction extends StatelessWidget {
  double widthLayout;

  CardLastTransaction({
    Key? key,
    required this.widthLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          textColor: Colors.black87,
          iconColor: Colors.black87,
          initiallyExpanded: true,
          title: const Text(
            'Transaksi Terakhir',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dividerThickness: 2,
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
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 120,
                            child: Center(
                              child: Text(
                                '1',
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 350,
                            child: Center(
                              child: Text(
                                'TR-MR-2022-RR-NJASDNJASBD',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 350,
                            child: Center(
                              child: Text(
                                '27 Mar 2022',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 350,
                            child: Center(
                              child: Text(
                                'Rp. 300.000',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
