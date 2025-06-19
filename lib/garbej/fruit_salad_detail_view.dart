// lib/features/fruit_salad/views/fruit_salad_detail_view.dart

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'fruit_salad_controller.dart';

class FruitSaladDetailView extends StatelessWidget {
  const FruitSaladDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FruitSaladController>();

    return Obx(() {
      final combo = controller.selectedCombo.value;
      if (combo == null) {
        return const Center(
          child: Text('No combo selected'),
        );
      }

      // Determine background color based on theme
      final backgroundColor = controller.isDarkMode.value
          ? const Color(0xFF0F172A) // Dark mode background color
          : const Color(0xFFF8FAFC); // Light mode background color

      return Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildHeroSection(combo, controller, controller.isDarkMode.value),
                ),
                Expanded(
                  flex: 3,
                  child: _buildDetailsSection(combo, controller, controller.isDarkMode.value),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: controller.confettiController,
                blastDirection: -3.14 / 2,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Color(0xFFFF8A65),
                  Color(0xFF6366F1),
                  Color(0xFF8B5CF6),
                  Color(0xFFFFB74D),
                  Color(0xFF4FC3F7),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeroSection(Map<String, dynamic> combo, FruitSaladController controller, bool isDarkMode) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [const Color(0xFF1E293B), const Color(0xFF334155)]
              : [const Color(0xFFFF8A65), const Color(0xFFFFB74D)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: controller.goBack,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          Gap(4.w),
                          Text(
                            'Go back',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3, end: 0),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Icon(
                      PhosphorIcons.addressBook(PhosphorIconsStyle.fill),
                      color: Colors.white,
                      size: 80.sp,
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).scale(begin: const Offset(0.6, 0.6)),
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(Map<String, dynamic> combo, FruitSaladController controller, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1E293B);
    final secondaryTextColor = isDarkMode ? Colors.white70 : const Color(0xFF64748B);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    combo['name'],
                    style: GoogleFonts.inter(
                      fontSize: 32.sp,
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildQuantitySelector(controller),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: 0.3, end: 0),
            Gap(8.h),
            Text(
              controller.formatCurrency(controller.totalPrice.value),
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                color: const Color(0xFFFF8A65),
                fontWeight: FontWeight.w700,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.2, end: 0),
            Gap(24.h),
            Text(
              'One Pack Contains:',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.2, end: 0),
            Gap(12.h),
            Text(
              (combo['ingredients'] as List<String>).join(', '),
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: secondaryTextColor,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
            Gap(24.h),
            if (combo['description'] != null) ...[
              Text(
                combo['description'],
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: secondaryTextColor,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: 0.2, end: 0),
              Gap(24.h),
            ],
            const Spacer(),
            Row(
              children: [
                GlassmorphicContainer(
                  width: 64.w,
                  height: 56.h,
                  borderRadius: 16.r,
                  blur: 10,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: Icon(
                    PhosphorIcons.heart(),
                    color: const Color(0xFFFF8A65),
                    size: 24.sp,
                  ),
                ),
                Gap(16.w),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.addToBasket,
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF8A65),
                            Color(0xFFFFB74D),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF8A65).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Obx(() {
                          if (controller.isAddingToBasket.value) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                Gap(12.w),
                                Text(
                                  'Adding...',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Text(
                            'Add to basket',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(FruitSaladController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: controller.decreaseQuantity,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: controller.quantity.value > 1
                    ? const Color(0xFFFF8A65)
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                PhosphorIcons.minus(PhosphorIconsStyle.bold),
                color: controller.quantity.value > 1
                    ? Colors.white
                    : const Color(0xFF94A3B8),
                size: 16.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(() => Text(
              controller.quantity.value.toString(),
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                color: const Color(0xFF1E293B),
                fontWeight: FontWeight.w600,
              ),
            )),
          ),
          GestureDetector(
            onTap: controller.increaseQuantity,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFF8A65),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                PhosphorIcons.plus(PhosphorIconsStyle.bold),
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
