import 'package:flutter/widgets.dart';

import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';

class SectionText extends StatelessWidget {
  const SectionText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: UiColors.white,
        fontSize: 16,
        fontWeight: Fonts.sfProTextBold,
      ),
    );
  }
}
