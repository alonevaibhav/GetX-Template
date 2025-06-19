// lib/features/fruit_salad/views/fruit_salad_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import 'fruit_salad_controller.dart';

class FruitSaladView extends StatelessWidget {
  const FruitSaladView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FruitSaladController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return _buildShimmerLoading();
          }

          return CustomScrollView(
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: _buildAppBar(controller)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.3, end: 0),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: _buildSearchBar(controller)
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 100.ms)
                    .slideX(begin: -0.2, end: 0),
              ),

              // Recommended Combos Section
              SliverToBoxAdapter(
                child: _buildRecommendedSection(controller)
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 200.ms)
                    .slideY(begin: 0.1, end: 0),
              ),

              // Category Tabs
              SliverToBoxAdapter(
                child: _buildCategoryTabs(controller)
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 300.ms)
                    .slideX(begin: -0.1, end: 0),
              ),

              // Hottest Combos Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: _buildHottestCombosGrid(controller),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAppBar(FruitSaladController controller) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          // Menu Icon
          GestureDetector(
            onTap: () => Get.toNamed('/menu'),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                PhosphorIcons.list(),
                size: 20.sp,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          const Spacer(),
          // Theme Toggle Button
          GestureDetector(
            onTap: controller.toggleTheme,
            child: Obx(() => GlassmorphicContainer(
              width: 48.w,
              height: 48.w,
              borderRadius: 12.r,
              blur: 10,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                colors: [
                  const Color(0xFFFF8A65).withOpacity(0.1),
                  const Color(0xFF6366F1).withOpacity(0.1),
                ],
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: Icon(
                controller.isDarkMode.value ? PhosphorIcons.sun() : PhosphorIcons.moon(),
                size: 20.sp,
                color: const Color(0xFFFF8A65),
              ),
            )),
          ),
          Gap(10.w),
          // Basket Icon
          GestureDetector(
            onTap: controller.goToBasket,
            child: GlassmorphicContainer(
              width: 48.w,
              height: 48.w,
              borderRadius: 12.r,
              blur: 10,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                colors: [
                  const Color(0xFFFF8A65).withOpacity(0.1),
                  const Color(0xFF6366F1).withOpacity(0.1),
                ],
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.shoppingCart(PhosphorIconsStyle.fill),
                    size: 18.sp,
                    color: const Color(0xFFFF8A65),
                  ),
                  Text(
                    'My basket',
                    style: GoogleFonts.inter(
                      fontSize: 8.sp,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSearchBar(FruitSaladController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          Text(
            'Hello ${controller.userName.value}, What fruit salad',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'combo do you want today?',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.w500,
            ),
          ),

          Gap(20.h),

          // Search Field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF1E293B),
              ),
              decoration: InputDecoration(
                hintText: 'Search for fruit salad combos',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF94A3B8),
                ),
                prefixIcon: Icon(
                  PhosphorIcons.magnifyingGlass(),
                  color: const Color(0xFF94A3B8),
                  size: 20.sp,
                ),
                suffixIcon: Icon(
                  PhosphorIcons.faders(),
                  color: const Color(0xFF94A3B8),
                  size: 20.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection(FruitSaladController controller) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Combo',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.w600,
            ),
          ),

          Gap(16.h),

          SizedBox(
            height: 180.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.recommendedCombos.length,
              separatorBuilder: (context, index) => Gap(16.w),
              itemBuilder: (context, index) {
                final combo = controller.recommendedCombos[index];
                return _buildRecommendedCard(combo, controller)
                    .animate()
                    .fadeIn(
                  duration: 600.ms,
                  delay: (100 * index).ms,
                )
                    .slideX(begin: 0.3, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(
      Map<String, dynamic> combo,
      FruitSaladController controller,
      ) {
    return GestureDetector(
      onTap: () => controller.selectCombo(combo),
      child: GlassmorphicContainer(
        width: 160.w,
        height: 180.h,
        borderRadius: 20.r,
        blur: 15,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Image
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A65), Color(0xFFFFB74D)],
                  ),
                ),
                child: Icon(
                  PhosphorIcons.addressBook(PhosphorIconsStyle.fill),
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),

              Gap(12.h),

              // Name
              Text(
                combo['name'],
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // Price and Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formatCurrency(combo['price']),
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color(0xFFFF8A65),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8A65),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      PhosphorIcons.plus(PhosphorIconsStyle.bold),
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(FruitSaladController controller) {
    final categories = ['Hottest', 'Popular', 'New combo', 'Top'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          final isSelected = controller.selectedTab.value == index;

          return GestureDetector(
            onTap: () => controller.selectTab(index),
            child: Container(
              margin: EdgeInsets.only(right: 24.w),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? const Color(0xFFFF8A65)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                category,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: isSelected
                      ? const Color(0xFFFF8A65)
                      : const Color(0xFF94A3B8),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHottestCombosGrid(FruitSaladController controller) {
    final combos = controller.hottestCombos;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final combo = combos[index];
          return _buildHottestComboCard(combo, controller, index)
              .animate()
              .fadeIn(
            duration: 600.ms,
            delay: (50 * index).ms,
          )
              .scale(begin: const Offset(0.8, 0.8));
        },
        childCount: combos.length,
      ),
    );
  }

  Widget _buildHottestComboCard(
      Map<String, dynamic> combo,
      FruitSaladController controller,
      int index,
      ) {
    return GestureDetector(
      onTap: () => controller.selectCombo(combo),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Heart Icon
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  PhosphorIcons.heart(),
                  color: const Color(0xFF94A3B8),
                  size: 20.sp,
                ),
              ),

              Gap(8.h),

              // Image
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6366F1).withOpacity(0.8),
                      const Color(0xFF8B5CF6).withOpacity(0.8),
                    ],
                  ),
                ),
                child: Icon(
                  PhosphorIcons.addressBook(PhosphorIconsStyle.fill),
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),

              Gap(12.h),

              // Name
              Text(
                combo['name'],
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: const Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // Price and Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formatCurrency(combo['price']),
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color(0xFFFF8A65),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8A65),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      PhosphorIcons.plus(PhosphorIconsStyle.bold),
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // App bar shimmer
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              const Spacer(),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),

          Gap(40.h),

          // Search bar shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),

          Gap(40.h),

          // Cards shimmer
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}