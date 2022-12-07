import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/my_constant.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  const ShowTitle({super.key, required this.title, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle ?? MyConstant().h3Style(),
    );
  }
}
