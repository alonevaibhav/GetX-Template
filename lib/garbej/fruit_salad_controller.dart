// lib/features/fruit_salad/controllers/fruit_salad_controller.dart

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FruitSaladController extends GetxController {
  // Reactive state variables
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final userName = 'Tony'.obs;
  final searchQuery = ''.obs;
  final selectedTab = 0.obs;
  final quantity = 1.obs;
  final selectedCombo = Rxn<Map<String, dynamic>>();
  final totalPrice = 0.0.obs;
  final isAddingToBasket = false.obs;

  // Confetti controller for celebration
  late ConfettiController confettiController;

  final isDarkMode = false.obs;

  // Method to toggle theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }

  // Mock data storage
  final recommendedCombos = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'Honey lime combo',
      'price': 2000.0,
      'image': 'assets/combo1.jpg',
      'ingredients': ['Honey', 'Lime', 'Mixed berries', 'Fresh mint'],
      'description': 'Sweet and tangy combination perfect for breakfast',
    },
    {
      'id': '2',
      'name': 'Berry mango combo',
      'price': 8000.0,
      'image': 'assets/combo2.jpg',
      'ingredients': ['Fresh berries', 'Mango', 'Strawberries', 'Kiwi'],
      'description': 'Tropical burst of flavors with antioxidants',
    },
  ].obs;

  final hottestCombos = <Map<String, dynamic>>[
    {
      'id': '3',
      'name': 'Quinoa fruit salad',
      'price': 10000.0,
      'image': 'assets/quinoa_salad.jpg',
      'ingredients': ['Red Quinoa', 'Lime', 'Honey', 'Blueberries', 'Strawberries', 'Mango', 'Fresh mint'],
      'description': 'If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you to make',
      'category': 'Protein Rich',
    },
    {
      'id': '4',
      'name': 'Tropical fruit salad',
      'price': 10000.0,
      'image': 'assets/tropical.jpg',
      'ingredients': ['Pineapple', 'Mango', 'Papaya', 'Coconut'],
      'description': 'Fresh tropical fruits with coconut flakes',
      'category': 'Exotic',
    },
    {
      'id': '5',
      'name': 'Melon combo',
      'price': 10000.0,
      'image': 'assets/melon.jpg',
      'ingredients': ['Watermelon', 'Cantaloupe', 'Honeydew', 'Mint'],
      'description': 'Refreshing melon medley perfect for summer',
      'category': 'Refreshing',
    },
  ].obs;

  final basketItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    confettiController = ConfettiController(duration: const Duration(seconds: 3));
    loadInitialData();
  }

  @override
  void onReady() {
    super.onReady();
    print('FruitSaladController is ready');
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

  // Load initial data
  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      // Data is already initialized above
      print('Initial data loaded successfully');
    } catch (e) {
      errorMessage.value = 'Failed to load data: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Failed to load fruit salad combos',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Search functionality
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    // In real app, this would filter the results
    print('Searching for: $query');
  }

  // Tab selection
  void selectTab(int index) {
    selectedTab.value = index;
  }

  // Select combo for detail view
  void selectCombo(Map<String, dynamic> combo) {
    selectedCombo.value = combo;
    quantity.value = 1;
    calculateTotalPrice();
    Get.toNamed('/fruit-salad-detail');
  }

  // Quantity management
  void increaseQuantity() {
    quantity.value++;
    calculateTotalPrice();
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      calculateTotalPrice();
    }
  }

  void calculateTotalPrice() {
    if (selectedCombo.value != null) {
      totalPrice.value = (selectedCombo.value!['price'] as double) * quantity.value;
    }
  }

  // Add to basket with celebration
  Future<void> addToBasket() async {
    if (selectedCombo.value == null) return;

    try {
      isAddingToBasket.value = true;

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      // Create basket item
      final basketItem = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'combo': selectedCombo.value!,
        'quantity': quantity.value,
        'totalPrice': totalPrice.value,
        'addedAt': DateTime.now().toIso8601String(),
      };

      basketItems.add(basketItem);

      // Trigger celebration animation
      confettiController.play();

      // Success feedback
      Get.snackbar(
        'Success! 🎉',
        '${selectedCombo.value!['name']} added to basket',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate back after short delay
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.back();

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to add item to basket',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isAddingToBasket.value = false;
    }
  }

  // Format currency
  String formatCurrency(double amount) {
    return '₦ ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )}';
  }

  // Get combo by category
  List<Map<String, dynamic>> getCombosByCategory(String category) {
    switch (category) {
      case 'recommended':
        return recommendedCombos;
      case 'hottest':
        return hottestCombos.where((combo) =>
        combo['category'] == null || combo['category'] == 'Protein Rich'
        ).toList();
      case 'popular':
        return hottestCombos.where((combo) =>
        combo['price'] >= 8000
        ).toList();
      case 'new':
        return hottestCombos.where((combo) =>
        combo['category'] == 'Exotic'
        ).toList();
      case 'top':
        return hottestCombos.where((combo) =>
        combo['category'] == 'Refreshing'
        ).toList();
      default:
        return hottestCombos;
    }
  }

  // Navigation helpers
  void goToBasket() {
    Get.toNamed('/basket');
  }

  void goBack() {
    Get.back();
  }
}