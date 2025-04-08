import 'package:flutter/material.dart';
import 'package:flutter_grocery/common/widgets/custom_image_widget.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';

class HomeCategoryItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function() onTap;
  const HomeCategoryItemWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          flex: 6,
          child: Container(
              margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CustomImageWidget(
                    image: image,
                    // image:
                    //     '${splashProvider.baseUrls?.categoryImageUrl}/${categoryProvider.categoryList?[index].image}',
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                ),
              ))),
      Expanded(
        flex: ResponsiveHelper.isDesktop(context) ? 3 : 2,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Text(
            title,
            style: poppinsRegular,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // child: Text(
          //   index != 7
          //       ? categoryProvider.categoryList![index].name!
          //       : getTranslated('view_all', context),
          //   style: poppinsRegular,
          //   textAlign: TextAlign.center,
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          // ),
        ),
      ),
    ]);
  }
}
