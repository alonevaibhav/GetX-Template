import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../Constants/color_constant.dart';

class ProfileView extends StatelessWidget {
  final ScrollController scrollController;
  const ProfileView({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetuColors.background,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h * 0.85,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: SetuColors.primaryGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SetuColors.primaryGreen,
                      SetuColors.lightGreen,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.w * 0.85,
                        height: 80.w * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          PhosphorIcons.user(PhosphorIconsStyle.regular),
                          size: 40.w * 0.85,
                          color: SetuColors.primaryGreen,
                        ),
                      ).animate().scale(duration: 800.ms, delay: 200.ms),
                      Gap(16.h * 0.85),
                      Text(
                        'Farmer Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp * 0.85,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                      Gap(4.h * 0.85),
                      Text(
                        'Village, District',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16.sp * 0.85,
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 16.w * 0.85),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r * 0.85),
                ),
                child: IconButton(
                  icon: Icon(PhosphorIcons.gear(PhosphorIconsStyle.regular),
                      color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w * 0.85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Gap(24.h * 0.85),
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 20.sp * 0.85,
                      fontWeight: FontWeight.bold,
                      color: SetuColors.textPrimary,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                  Gap(16.h * 0.85),
                  _buildPersonalInfo()
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 1000.ms),
                  Gap(24.h * 0.85),
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 20.sp * 0.85,
                      fontWeight: FontWeight.bold,
                      color: SetuColors.textPrimary,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 1200.ms),
                  Gap(16.h * 0.85),
                  ...List.generate(
                      10,
                      (index) => _buildSettingsItem(index, context)
                          .animate()
                          .fadeIn(
                              duration: 600.ms,
                              delay: (1400 + (index * 100)).ms)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildPersonalInfo() {
    final personalInfo = [
      {
        'label': 'Full Name',
        'value': 'Rajesh Kumar',
        'icon': PhosphorIcons.user(PhosphorIconsStyle.regular)
      },
      {
        'label': 'Aadhaar Number',
        'value': '****-****-1234',
        'icon': PhosphorIcons.identificationCard(PhosphorIconsStyle.regular)
      },
      {
        'label': 'Mobile Number',
        'value': '+91 98765-43210',
        'icon': PhosphorIcons.phone(PhosphorIconsStyle.regular)
      },
      {
        'label': 'Village',
        'value': 'Greenfield Village',
        'icon': PhosphorIcons.mapPin(PhosphorIconsStyle.regular)
      },
      {
        'label': 'District',
        'value': 'Rural District',
        'icon': PhosphorIcons.house(PhosphorIconsStyle.regular)
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: SetuColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r * 0.85),
        boxShadow: [
          BoxShadow(
            color: SetuColors.primaryGreen.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: personalInfo.asMap().entries.map((entry) {
          final index = entry.key;
          final info = entry.value;
          final isLast = index == personalInfo.length - 1;
          return Container(
            padding: EdgeInsets.all(16.w * 0.85),
            decoration: BoxDecoration(
              border: !isLast
                  ? Border(
                      bottom: BorderSide(
                        color: SetuColors.lightGreen.withOpacity(0.2),
                        width: 1,
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w * 0.85),
                  decoration: BoxDecoration(
                    color: SetuColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r * 0.85),
                  ),
                  child: Icon(
                    info['icon'] as IconData?,
                    color: SetuColors.primaryGreen,
                    size: 20.w * 0.85,
                  ),
                ),
                Gap(16.w * 0.85),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info['label'] as String,
                        style: TextStyle(
                          fontSize: 12.sp * 0.85,
                          color: SetuColors.textSecondary,
                        ),
                      ),
                      Gap(2.h * 0.85),
                      Text(
                        info['value'] as String,
                        style: TextStyle(
                          fontSize: 16.sp * 0.85,
                          fontWeight: FontWeight.w600,
                          color: SetuColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  PhosphorIcons.pencilSimple(PhosphorIconsStyle.regular),
                  color: SetuColors.textSecondary,
                  size: 16.w * 0.85,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsItem(int index, BuildContext context) {
    final settings = [
      {
        'title': 'Edit Profile',
        'subtitle': 'Update your personal information',
        'icon': PhosphorIcons.userCircle(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Notifications',
        'subtitle': 'Manage your notification preferences',
        'icon': PhosphorIcons.bell(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Privacy & Security',
        'subtitle': 'Control your privacy settings',
        'icon': PhosphorIcons.shield(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Language',
        'subtitle': 'Change app language',
        'icon': PhosphorIcons.translate(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Help & Support',
        'subtitle': 'Get help or contact support',
        'icon': PhosphorIcons.question(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Terms & Conditions',
        'subtitle': 'Read our terms and conditions',
        'icon': PhosphorIcons.fileText(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Privacy Policy',
        'subtitle': 'Read our privacy policy',
        'icon': PhosphorIcons.file(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Rate App',
        'subtitle': 'Rate us on the app store',
        'icon': PhosphorIcons.star(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Share App',
        'subtitle': 'Share this app with friends',
        'icon': PhosphorIcons.shareNetwork(PhosphorIconsStyle.regular)
      },
      {
        'title': 'Logout',
        'subtitle': 'Sign out from your account',
        'icon': PhosphorIcons.signOut(PhosphorIconsStyle.regular)
      },
    ];

    final setting = settings[index % settings.length];
    final isLogout = setting['title'] == 'Logout';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h * 0.85),
      decoration: BoxDecoration(
        color: SetuColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r * 0.85),
        boxShadow: [
          BoxShadow(
            color: SetuColors.primaryGreen.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w * 0.85, vertical: 8.h * 0.85),
        leading: Container(
          padding: EdgeInsets.all(8.w * 0.85),
          decoration: BoxDecoration(
            color: isLogout
                ? SetuColors.error.withOpacity(0.1)
                : SetuColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r * 0.85),
          ),
          child: Icon(
            setting['icon'] as IconData?,
            color: isLogout ? SetuColors.error : SetuColors.primaryGreen,
            size: 20.w * 0.85,
          ),
        ),
        title: Text(
          setting['title'] as String,
          style: TextStyle(
            fontSize: 16.sp * 0.85,
            fontWeight: FontWeight.w600,
            color: isLogout ? SetuColors.error : SetuColors.textPrimary,
          ),
        ),
        subtitle: Text(
          setting['subtitle'] as String,
          style: TextStyle(
            fontSize: 12.sp * 0.85,
            color: SetuColors.textSecondary,
          ),
        ),
        trailing: Icon(
          PhosphorIcons.caretRight(PhosphorIconsStyle.regular),
          color: SetuColors.textSecondary,
          size: 16.w * 0.85,
        ),
        onTap: () {
          if (isLogout) {
            _showLogoutDialog(context);
          } else {
            print('Tapped on ${setting['title']}');
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: SetuColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r * 0.85),
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 20.sp * 0.85,
              fontWeight: FontWeight.bold,
              color: SetuColors.textPrimary,
            ),
          ),
          content: Text(
            'Are you sure you want to logout from your account?',
            style: TextStyle(
              fontSize: 16.sp * 0.85,
              color: SetuColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: SetuColors.textSecondary,
                  fontSize: 16.sp * 0.85,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('User logged out');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: SetuColors.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r * 0.85),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16.sp * 0.85,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
