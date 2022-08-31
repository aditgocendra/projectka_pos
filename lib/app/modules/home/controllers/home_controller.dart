import 'package:get/get.dart';

class HomeController extends GetxController {
  // Sidebar
  final isSidebarExpanded = true.obs;
  final indexSidebarSelected = 0.obs;

  //Transaction

  List<Map<String, dynamic>> listProductSelect = [];
  final countProductTransaction = 0.obs;
}
