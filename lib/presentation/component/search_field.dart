import 'package:flutter/material.dart';

import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.controller,
    this.onSearchPressed,
    this.onEmptySearch,
  });

  final TextEditingController? controller;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onEmptySearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: UiColors.black,
      ),
      child: TextField(
        controller: controller,
        onChanged: (String text) {
          if (text.isEmpty && onEmptySearch != null) {
            onEmptySearch!();
          }
        },
        style: TextStyle(
          fontWeight: Fonts.sfProTextRegular,
          fontFamily: Fonts.sfProText,
          color: UiColors.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: UiColors.primary),
            onPressed: onSearchPressed,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: UiColors.white.withOpacity(0.12), width: 0.86),
          ),
          hintStyle: TextStyle(
            fontWeight: Fonts.sfProTextRegular,
            fontFamily: Fonts.sfProText,
            color: UiColors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
