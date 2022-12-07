import 'package:flutter/material.dart';

import '../utils/my_constant.dart';
import 'show_image.dart';
import 'show_title.dart';

class ShowNoData extends StatelessWidget {
  final String title, pathImage;
  const ShowNoData({
    Key? key,
    required this.title,
    required this.pathImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            width: 200,
            child: ShowImage(path: pathImage),
          ),
          ShowTitle(
            title: title,
            textStyle: MyConstant().h1Style(),
          ),
        ],
      ),
    );
  }
}
