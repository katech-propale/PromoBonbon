import 'package:flutter/material.dart';
import 'package:flutter_grocery/common/enums/footer_type_enum.dart';
import 'package:flutter_grocery/common/widgets/footer_web_widget.dart';
import 'package:flutter_grocery/common/widgets/not_login_widget.dart';
import 'package:flutter_grocery/features/auth/providers/auth_provider.dart';
import 'package:flutter_grocery/features/profile/providers/profile_provider.dart';
import 'package:flutter_grocery/features/profile/widgets/profile_details_widget.dart';
import 'package:flutter_grocery/features/profile/widgets/profile_header_widget.dart';
import 'package:flutter_grocery/localization/app_localization.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:provider/provider.dart';

class MyInformationScreen extends StatefulWidget {
  const MyInformationScreen({super.key});

  @override
  _MyInformationScreenState createState() => _MyInformationScreenState();
}

class _MyInformationScreenState extends State<MyInformationScreen> {
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        title: Text('my_information'.tr,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeLarge,
                fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: _isLoggedIn
            ? Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall),
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(child: ProfileHeaderWidget()),
                      SliverToBoxAdapter(child: ProfileDetailsWidget()),
                      FooterWebWidget(footerType: FooterType.sliver),
                    ]),
                  );
                },
              )
            : const NotLoggedInWidget(),
      ),
    );
  }
}
