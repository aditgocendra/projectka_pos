import 'package:unicons/unicons.dart';

abstract class SidebarConstantData {
  static const List<Map<String, dynamic>> listMenuDashboard = [
    {
      'title': 'Dashboard',
      'icon': UniconsLine.home_alt,
    },
    {
      'title': 'Produk',
      'icon': UniconsLine.box,
    },
    {
      'title': 'Transaksi',
      'icon': UniconsLine.transaction,
    },
    {
      'title': 'Pengguna',
      'icon': UniconsLine.user_circle,
    },
  ];

  static List<Map<String, dynamic>> trailing = [
    {'icon': UniconsLine.angle_right},
    {'icon': UniconsLine.sign_out_alt}
  ];
}
