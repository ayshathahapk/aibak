import 'package:flutter/material.dart';
import 'package:aibak/Core/Utils/size_utils.dart';

String _appTheme = "lightCode";

CodeColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, CodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors(),
    'darkCode': DarkCodeColors(),
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme,
    'darkCode': ColorSchemes.darkCodeColorScheme,
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  CodeColors _getThemeColors() {
    // if (_appTheme == 'lightCode') {
    //   return LightCodeColors();
    // } else if (_appTheme == 'darkCode') {
    //   return DarkCodeColors();
    // } else {
    //   throw Exception('Unknown theme');
    // }
    final code = _supportedCustomColor[_appTheme] ?? LightCodeColors();
    return code;
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      dialogBackgroundColor: appTheme.whiteA700,
      dialogTheme: DialogTheme(backgroundColor: appTheme.whiteA700),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.whiteA700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.black900,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  CodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.gray70001,
          fontSize: 15.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.black900,
          fontSize: 12.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 30.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w800,
        ),
        headlineSmall: TextStyle(
          color: appTheme.yellow900,
          fontSize: 25.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: appTheme.red700,
          fontSize: 10.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 20.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 18.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 15.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
  static final darkCodeColorScheme = ColorScheme.dark();
}

/// Abstract class For Two Mods

abstract class CodeColors {
  // Black
  Color get black900;

  // BlueGray
  Color get blueGray400;

  Color get blueGray900;

  Color get blue600;

  // Gray
  Color get gray400;

  Color get gray300;

  Color get gray50;

  Color get gray500;

  Color get gray5001;

  Color get gray600;

  Color get gray700;

  Color get gray70001;

  Color get gray800;

  // Pink
  Color get pink100;

  // Red
  Color get red50;

  Color get red700;

  Color get mainBlue;

  Color get mainGreen;

  Color get mainWhite;

  Color get mainBlack;

  Color get mainGray;

  Color get red100;

  Color get orange;

  Color get gold;

  Color get green;

  Color get red70001;

  // White
  Color get whiteA700;

  // Yellow
  Color get yellow900;

  Color get yellow700;
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors implements CodeColors {
  // Black
  Color get black900 => Color(0XFF000000);

// BlueGray
  Color get blueGray400 => Color(0XFF888888);

  Color get blueGray900 => Color(0XFF343434);

  Color get blue600 => Color(0xFF033f71);

// Gray
  Color get gray400 => Color(0XFFC6C6C6);

  Color get gray300 => Colors.grey.shade300;

  Color get gray50 => Color(0XFFFFF5F6);

  Color get gray500 => Color(0XFFA0A0A0);

  Color get gray5001 => Color(0XFFFFF5F7);

  Color get gray600 => Color(0XFF7A7A7A);

  Color get gray700 => Color(0XFF646464);

  Color get gray70001 => Color(0XFF585858);

  Color get gray800 => Color(0XFF464646);

// Pink
  Color get pink100 => Color(0XFFFFACB8);

// Red
  Color get red50 => Color(0XFFFFEFF2);

  Color get red700 => Color(0XFFCC243E);

  Color get mainBlue => Color(0xFF163042);

  Color get mainGreen => Color(0xFF84af40);

  Color get mainWhite => Color(0xFFf0efef);

  Color get mainBlack => Color(0xFF353535);

  Color get mainGray => Color(0xFFA7A7A8);

  // Color get red700 => Color(0XFFCC243E);
  Color get red100 => Colors.red.shade100;

  Color get orange => Colors.orange;
  Color get gold => const Color(0xFFdbbd75);

  Color get green => Colors.green;

  Color get red70001 => Color(0XFFD33339);

// White
  Color get whiteA700 => Color(0XFFFFFFFF);

// Yellow
  Color get yellow900 => Color(0XFFF37421);

  Color get yellow700 => Color(0xFFBFA13A);
}

/// Class containing custom colors for a darkCode theme.
class DarkCodeColors implements CodeColors {
  // Black
  Color get black900 => Color(0XFF000000);

  // BlueGray
  Color get blueGray400 => Color(0XFF888888);

  Color get blueGray900 => Color(0XFF343434);

  Color get blue600 => Color(0xFF033f71);

  Color get blue => Color(0xFF033f71);

  // Gray
  Color get gray400 => Color(0XFFC6C6C6);

  Color get gray300 => Colors.grey.shade300;

  Color get gray50 => Color(0XFFFFF5F6);

  Color get gray500 => Color(0XFFA0A0A0);

  Color get gray5001 => Color(0XFFFFF5F7);

  Color get gray600 => Color(0XFF7A7A7A);

  Color get gray700 => Color(0XFF646464);

  Color get gray70001 => Color(0XFF585858);

  Color get gray800 => Color(0XFFA0A0A0);

  // Pink
  Color get pink100 => Color(0XFFFFACB8);

  // Red
  Color get red50 => Color(0XFFFFEFF2);

  Color get red700 => Color(0XFFCC243E);

  Color get mainBlue => Color(0xFFf0efef);

  Color get mainGreen => Color(0xFF84af40);

  Color get mainWhite => Color(0xFF163042);

  Color get mainBlack => Color(0xFF353535);

  Color get mainGray => Color(0xFFA7A7A8);

  Color get red100 => Colors.red.shade100;

  Color get orange => Colors.orange;
  Color get gold => Color(0xFFdbbd75);

  Color get green => Colors.green;

  Color get red70001 => Color(0XFFD33339);

  // White
  Color get whiteA700 => Color(0xFF163042);

  // Yellow
  Color get yellow900 => Color(0XFFF37421);

  Color get yellow700 => Color(0xFFBFA13A);
}
