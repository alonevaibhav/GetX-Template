// lib/app/routes/app_routes.dart

import 'package:get/get.dart';
import 'bf.dart';
import 'fruit_salad_detail_view.dart';
import 'fruit_salad_view.dart';

class AppRoutes {
  static const String fruitSaladHome = '/fruit-salad';
  static const String fruitSaladDetail = '/fruit-salad-detail';

  static List<GetPage> routes = [
    GetPage(
      name: fruitSaladHome,
      page: () => const FruitSaladView(),
      binding: FruitSaladBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: fruitSaladDetail,
      page: () => const FruitSaladDetailView(),
      binding: FruitSaladBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}