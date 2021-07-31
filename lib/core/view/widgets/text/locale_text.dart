import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../init/extension/string_extensions.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  const LocaleText({
    Key? key,
    required this.text,
    this.style = const TextStyle(),
    this.textAlign,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.locale,
      style: style,
      textAlign: textAlign,
    );
  }
}
