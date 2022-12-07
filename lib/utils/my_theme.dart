import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'my_constant.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    primaryColor: MyConstant.dark,
    iconTheme: IconThemeData(color: MyConstant.light),
    textTheme: TextTheme(
      headline1: MyConstant().h1StyleDarkTheme(),
      headline2: MyConstant().h2StyleDarkTheme(),
      headline3: MyConstant().h3StyleDarkTheme(),
      bodyText1: MyConstant().b1StyleLightTheme(),
    ),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: MyConstant.light,
    iconTheme: IconThemeData(color: MyConstant.dark),
    textTheme: TextTheme(
      headline1: MyConstant().h1StyleLightTheme(),
      headline2: MyConstant().h2StyleLightTheme(),
      headline3: MyConstant().h3StyleLightTheme(),
      bodyText1: MyConstant().b1StyleLightTheme(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(
          context,
          listen: false,
        );
        provider.toggleTheme(value);
      },
    );
  }
}
