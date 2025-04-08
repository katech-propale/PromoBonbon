import 'package:flutter/material.dart';
import 'package:flutter_grocery/common/models/product_model.dart';
import 'package:flutter_grocery/localization/app_localization.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';

class HeaderProductDetailsWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<Rating> rate;
  const HeaderProductDetailsWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(description.isNotEmpty ? description : 'no_description'.tr,
                style: const TextStyle(fontSize: 16)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorResources.ratingColor.withOpacity(0.1),
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.star_rounded,
                    color: ColorResources.ratingColor,
                    size: Dimensions.paddingSizeDefault),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Text(
                  rate.isNotEmpty
                      ? double.parse(rate[0].average!).toStringAsFixed(1)
                      : '0.0',
                  style: poppinsMedium.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.6),
                      fontSize: Dimensions.fontSizeSmall),
                ),
              ]),
        )
      ],
    );
  }
}
