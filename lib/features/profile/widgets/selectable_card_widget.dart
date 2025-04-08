import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectableCardWidget extends StatelessWidget {
  final String label;
  final String? subtitle;
  final String trailing;
  final Widget? action;
  final Function()? onTap;
  final Widget? leading;
  const SelectableCardWidget(
      {super.key,
      required this.label,
      this.subtitle,
      this.action,
      this.onTap,
      this.leading,
      this.trailing = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            /// Sinon le titre ou la description est focus quand on revient sur
            /// la page sell s'il était déjà focus avant de quitter la page
            FocusScope.of(context).unfocus();
          }
          if (onTap != null) {
            onTap!();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (leading != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 20, top: 2),
                              child: leading!,
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  label,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (subtitle != null)
                                  Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: SizedBox(
                                        width: 300,
                                        child: Text(
                                          subtitle!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                          softWrap: true,
                                        ),
                                      )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: action != null
                          ? action!
                          : trailing.isNotEmpty
                              ? SizedBox(
                                  width: 150,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(trailing,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500))))
                              : SvgPicture.asset(
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context).primaryColor,
                                      BlendMode.srcIn),
                                  "assets/image/arrow_right.svg"),
                    ),
                  ],
                ),
              )),
        ));
  }
}
