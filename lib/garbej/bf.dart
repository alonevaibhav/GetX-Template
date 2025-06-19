// lib/features/fruit_salad/bindings/fruit_salad_binding.dart

import 'package:get/get.dart';
import 'fruit_salad_controller.dart';

class FruitSaladBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FruitSaladController>(
          () => FruitSaladController(),
    );
  }
}