import 'package:flutter/material.dart';
import 'package:flutter_grocery/common/enums/footer_type_enum.dart';
import 'package:flutter_grocery/common/enums/html_type_enum.dart';
import 'package:flutter_grocery/common/widgets/footer_web_widget.dart';
import 'package:flutter_grocery/common/widgets/not_login_widget.dart';
import 'package:flutter_grocery/common/widgets/web_app_bar_widget.dart';
import 'package:flutter_grocery/features/address/screens/add_new_address_screen.dart';
import 'package:flutter_grocery/features/address/screens/address_list_screen.dart';
import 'package:flutter_grocery/features/auth/providers/auth_provider.dart';
import 'package:flutter_grocery/features/html/screens/html_viewer_screen.dart';
import 'package:flutter_grocery/features/menu/screens/setting_screen.dart';
import 'package:flutter_grocery/features/menu/widgets/sign_out_dialog_widget.dart';
import 'package:flutter_grocery/features/profile/providers/profile_provider.dart';
import 'package:flutter_grocery/features/profile/screens/my_information_screen.dart';
import 'package:flutter_grocery/features/profile/widgets/profile_details_widget.dart';
import 'package:flutter_grocery/features/profile/widgets/profile_header_widget.dart';
import 'package:flutter_grocery/features/profile/widgets/selectable_card_widget.dart';
import 'package:flutter_grocery/features/splash/providers/splash_provider.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/app_localization.dart';
import 'package:flutter_grocery/localization/language_constraints.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/padding.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    if (_isLoggedIn) {
      Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(true, isUpdate: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider =
        Provider.of<SplashProvider>(context, listen: false);
    final bool isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return Scaffold(
      body: Column(
        children: [
          SelectableCardWidget(
            label: 'my_information'.tr,
            onTap: () {
              Navigator.of(context).pushNamed(RouteHelper.myInformation,
                  arguments: const MyInformationScreen());
            },
          ).paddedB(16),
          SelectableCardWidget(
            label: 'settings'.tr,
            onTap: () {
              Navigator.of(context).pushNamed(RouteHelper.settings,
                  arguments: const SettingsScreen());
            },
          ).paddedB(16),
          SelectableCardWidget(
            label: 'address'.tr,
            onTap: () {
              Navigator.of(context).pushNamed(RouteHelper.address,
                  arguments: const AddressListScreen());
            },
          ).paddedB(42),
          SelectableCardWidget(
            label: 'terms_and_condition'.tr,
            onTap: () {
              Navigator.of(context).pushNamed(RouteHelper.termsScreen,
                  arguments: const HtmlViewerScreen(
                      htmlType: HtmlType.termsAndCondition));
            },
          ).paddedB(16),
          SelectableCardWidget(
            label: 'privacy_policy'.tr,
            onTap: () {
              Navigator.of(context).pushNamed(RouteHelper.termsScreen,
                  arguments:
                      const HtmlViewerScreen(htmlType: HtmlType.privacyPolicy));
            },
          ).paddedB(16),
          SelectableCardWidget(
            label: 'faq'.tr,
            onTap: () {
              Navigator.pushNamed(context, RouteHelper.getFaqRoute());
            },
          ).paddedB(16),
          SelectableCardWidget(
            label: 'log_out'.tr,
            action: SvgPicture.asset(Images.logOut, width: 25, height: 25),
            onTap: () {
              if (isLoggedIn) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const SignOutDialogWidget());
              } else {
                splashProvider.setPageIndex(0);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteHelper.getLoginRoute(), (route) => false);
              }
            },
          ).paddedB(16),
        ],
      ).paddedV(16),
    );
  }
}
