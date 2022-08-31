import 'package:unicons/unicons.dart';

abstract class DashboardConstant {
  static const List<Map<String, dynamic>> headerCard = [
    {
      'title': 'Jumlah Transaksi',
      'icon': UniconsLine.transaction,
    },
    {
      'title': 'Jumlah Produk',
      'icon': UniconsLine.box,
    },
    {
      'title': 'Jumlah Pengguna',
      'icon': UniconsLine.user_circle,
    }
  ];
}
