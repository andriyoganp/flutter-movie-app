import 'package:flutter/material.dart';

import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';

class TextPlaceholder extends StatelessWidget {
  const TextPlaceholder({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Cannot load data',
        style: TextStyle(
          fontSize: 16,
          fontWeight: Fonts.sfProTextMedium,
          fontFamily: Fonts.sfProText,
          color: UiColors.white,
        ),
      ),
    );
  }
}
