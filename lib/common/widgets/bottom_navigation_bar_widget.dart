import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_grocery/features/splash/providers/splash_provider.dart';
import 'package:flutter_grocery/localization/app_localization.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider = Provider.of<SplashProvider>(context);

    return Container(
      height: Platform.isIOS ? 90 : 56, // Hauteur standard Material Design
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 4,
            offset: const Offset(0, -1),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).hintColor.withOpacity(0.7),
          showUnselectedLabels: true,
          backgroundColor: Theme.of(context).cardColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: splashProvider.pageIndex,
          elevation: 0,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          selectedLabelStyle:
              poppinsRegular.copyWith(fontWeight: FontWeight.w500),
          unselectedLabelStyle: poppinsRegular,
          onTap: (int index) => splashProvider.setPageIndex(index),
          items: [
            _buildNavigationBarItem(
                context, 'home'.tr, Icons.home_outlined, Icons.home, 0),
            _buildNavigationBarItem(context, 'my_order'.tr,
                Icons.category_outlined, Icons.category, 1),
            _buildNavigationBarItem(context, 'shopping_bag'.tr,
                Icons.shopping_cart_outlined, Icons.shopping_cart, 2),
            _buildNavigationBarItem(
                context, 'live_chat'.tr, Icons.message, Icons.favorite, 3),
            _buildNavigationBarItem(
                context, 'profile'.tr, Icons.person_outline, Icons.person, 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(BuildContext context,
      String label, IconData unselectedIcon, IconData selectedIcon, int index) {
    final SplashProvider splashProvider = Provider.of<SplashProvider>(context);
    final bool isSelected = splashProvider.pageIndex == index;

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.only(bottom: 3),
        child: Icon(
          isSelected ? selectedIcon : unselectedIcon,
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).hintColor.withOpacity(0.7),
          size: 22,
        ),
      ),
      label: label,
    );
  }
}
