import 'package:drought_sphere/screens/drought_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/landing_page.dart';
import 'utils/my_constant.dart';
import 'utils/my_theme.dart';

final Map<String, WidgetBuilder> mapRoute = {
  '/landingPage': (context) => const LandingPage(),
  '/droughtPage': (context) => const DroughtPage(),
};

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static String title = MyConstant.appName;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          routes: mapRoute,
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          initialRoute: MyConstant.routhDrought,
        );
      });
}
