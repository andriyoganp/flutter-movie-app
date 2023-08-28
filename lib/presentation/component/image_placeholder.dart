import 'package:flutter/material.dart';

import '../../ui/resource/ui_colors.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: UiColors.white.withOpacity(0.7),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(Icons.image_outlined, color: UiColors.primary),
    );
  }
}
