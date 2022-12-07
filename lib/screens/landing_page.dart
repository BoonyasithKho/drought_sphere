import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../utils/my_constant.dart';
import '../utils/my_theme.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: MyConstant.appName,
          textStyle: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: const [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Center(
        child: ShowImage(path: MyConstant.gistdaLogo),
      ),
    );
  }
}
