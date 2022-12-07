import 'package:flutter/material.dart';

class MyConstant {
  static String appName = 'Application Name';
  static String domain = '';
  static String publicKey = '';
  static String secretKey = '';

  static String routeLanding = '/landingPage';
  static String routhDrought = '/droughtPage';
  static String routhDroughtFlutterMap = '/droughtFlutterMap';

  static Color primary = const Color(0xff87861d);
  static Color dark = const Color(0xff575900);
  static Color light = const Color(0xffb9b64e);
  static Map<int, Color> mapMaterialColor = {
    50: const Color.fromRGBO(255, 87, 89, 0.1),
    100: const Color.fromRGBO(255, 87, 89, 0.2),
    200: const Color.fromRGBO(255, 87, 89, 0.3),
    300: const Color.fromRGBO(255, 87, 89, 0.4),
    400: const Color.fromRGBO(255, 87, 89, 0.5),
    500: const Color.fromRGBO(255, 87, 89, 0.6),
    600: const Color.fromRGBO(255, 87, 89, 0.7),
    700: const Color.fromRGBO(255, 87, 89, 0.8),
    800: const Color.fromRGBO(255, 87, 89, 0.9),
    900: const Color.fromRGBO(255, 87, 89, 1.0),
  };

  static String gistdaLogo = 'assets/images/gistda_logo.png';
  static String avatar = 'assets/images/avatar.png';
  static String image1 = 'assets/images/image1.png';
  static String image2 = 'assets/images/image2.png';
  static String image3 = 'assets/images/image3.png';
  static String image4 = 'assets/images/image4.png';
  static String image5 = 'assets/images/image5.png';
  static String urlPrompay = 'https://promptpay.io/0996170176.png';
  static String bills = 'assets/images/bill.png';

  static String fontFamily = 'Prompt';

  TextAlign textAlignCenter() => TextAlign.center;

  TextStyle h1StyleLightTheme() => TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: dark, fontFamily: fontFamily);
  TextStyle h1StyleDarkTheme() => TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: light, fontFamily: fontFamily);
  TextStyle h2StyleLightTheme() => TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: dark, fontFamily: fontFamily);
  TextStyle h2StyleDarkTheme() => TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: light, fontFamily: fontFamily);
  TextStyle h3StyleLightTheme() => TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: dark, fontFamily: fontFamily);
  TextStyle h3StyleDarkTheme() => TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: light, fontFamily: fontFamily);
  TextStyle b1StyleLightTheme() => TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: dark, fontFamily: fontFamily);
  TextStyle b1StyleDarkTheme() => TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: light, fontFamily: fontFamily);
  TextStyle toolTips() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: dark,
        fontFamily: fontFamily,
      );
  TextStyle hBtnStyle() => TextStyle(
        fontSize: 22,
        color: dark,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );

  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: dark,
        fontFamily: fontFamily,
      );
  TextStyle h1WhiteStyle() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: fontFamily,
      );
  TextStyle h1RedStyle() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.red,
        fontFamily: fontFamily,
      );
  TextStyle h1BlueStyle() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        fontFamily: fontFamily,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );
  TextStyle h2RedStyle() => TextStyle(
        fontSize: 18,
        color: Colors.red,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );
  TextStyle h2BlueStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      );
  TextStyle h3RedStyle() => TextStyle(
        fontSize: 14,
        color: Colors.red,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      );
  TextStyle h3BlueStyle() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.blue,
        fontFamily: fontFamily,
      );

  ButtonStyle btnStyle() => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: MyConstant.primary,
      );

  BoxDecoration gradintLinearBackground() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, MyConstant.light, MyConstant.primary],
        ),
      );

  BoxDecoration planBackground() => BoxDecoration(
        color: MyConstant.light.withOpacity(0.75),
      );

  BoxDecoration gradientRadialBackground() => BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.5),
          radius: 1.5,
          colors: [Colors.white, MyConstant.primary],
        ),
      );
}
