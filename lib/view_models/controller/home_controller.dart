import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedFilterIndex = 0.obs;
  var selectedVentureIndex = 0.obs;

  final List<String> filters = [
    'all',
    'contact',
    'blog_contact',
    'quotation',
    'course_purchase'
  ];

  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
  }
}
