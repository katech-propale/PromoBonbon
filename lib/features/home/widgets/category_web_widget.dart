import 'package:flutter/material.dart';
import 'package:flutter_grocery/features/category/widgets/category_item_widget.dart';
import 'package:flutter_grocery/features/home/widgets/category_item_widget.dart';
import 'package:flutter_grocery/features/home/widgets/category_page_widget.dart';
import 'package:flutter_grocery/features/home/widgets/category_shimmer_widget.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constraints.dart';
import 'package:flutter_grocery/features/category/providers/category_provider.dart';
import 'package:flutter_grocery/features/splash/providers/splash_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/common/widgets/custom_image_widget.dart';
import 'package:flutter_grocery/common/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('------load-----------');

    final SplashProvider splashProvider =
        Provider.of<SplashProvider>(context, listen: false);

    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
      print('--------cate-------${categoryProvider.categoryList}');
      return categoryProvider.categoryList == null
          ? const CategoriesShimmerWidget()
          : (categoryProvider.categoryList?.isNotEmpty ?? false)
              ? Container(
                  height: 120, // Hauteur ajustée pour une meilleure apparence
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListView.builder(
                    itemCount: categoryProvider.categoryList?.length,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < 0 ||
                          categoryProvider.categoryList == null ||
                          index >= categoryProvider.categoryList!.length) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            categoryProvider.onChangeSelectIndex(-1,
                                notify: false);
                            Navigator.of(context).pushNamed(
                              RouteHelper.getCategoryProductsRoute(
                                  categoryId:
                                      '${categoryProvider.categoryList![index].id}'),
                            );
                          },
                          child: HomeCategoryItemWidget(
                            image:
                                '${splashProvider.baseUrls?.categoryImageUrl}/${categoryProvider.categoryList?[index].image}',
                            title: categoryProvider.categoryList![index].name!,
                            onTap: () {
                              categoryProvider.onChangeSelectIndex(-1,
                                  notify: false);
                              Navigator.of(context).pushNamed(
                                RouteHelper.getCategoryProductsRoute(
                                    categoryId:
                                        '${categoryProvider.categoryList![index].id}'),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox();
    });
  }
}
