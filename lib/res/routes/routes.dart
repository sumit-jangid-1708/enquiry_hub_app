import 'package:enquiry_hub/view/ahec/ahec_detail_view.dart';
import 'package:get/get.dart';
import '../../view/ahit/ahit_detail_view.dart';
import '../../view/auth/pin_entry_view.dart';
import '../../view/dashboard/dashboard_view.dart';
import '../../view/bbsmit/bbsmit_view.dart';
import '../../view/bbsmit/bbsmit_detail_view.dart';
import '../../view/tour_monks/tour_detail_view.dart';
import 'routes_names.dart';

class AppRoutes {
  static List<GetPage> appRoute() => [
    GetPage(
      name: RouteName.pinEntryScreen,
      page: () => PinEntryView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteName.dashboard,
      page: () => DashboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.bbsmitView,
      page: () => const BbsmitView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteName.bbsmitDetailView,
      page: () => const BbsmitDetailView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.ahitDetailView,
      page: () => const AhitDetailView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.tourDetailView,
      page: () => const TourDetailView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.ahecDetailView,
      page: () => const AhecDetailView(),
      transition: Transition.cupertino,
    ),
  ];
}
