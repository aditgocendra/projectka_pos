import 'package:unicons/unicons.dart';

abstract class RightbarConstant {
  static const List<Map<String, dynamic>> actionList = [
    {
      'title': 'Tambah Produk',
      'icon': UniconsLine.book_medical,
    },
    {
      'title': 'Tambah Transaksi',
      'icon': UniconsLine.transaction,
    },
    {
      'title': 'Laporan Produk',
      'icon': UniconsLine.file_download,
    },
    {
      'title': 'Laporan Transaksi',
      'icon': UniconsLine.file_graph,
    }
  ];
}
