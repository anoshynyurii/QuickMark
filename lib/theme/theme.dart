import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const lightBackground = Color(0xFFECE7D1);
  static const lightSurface = Color(0xFFF5F1DE);
  static const lightPrimary = Color(0xFF8A7650);
  static const lightSecondary = Color(0xFFB7A77A);
  static const lightTextPrimary = Color(0xFF2B2B2B);
  static const lightTextSecondary = Color(0xFF6E6A5E);
  static const lightBorder = Color(0xFFD6D1BB);

  static const darkBackground = Color(0xFF1E1C17);
  static const darkSurface = Color(0xFF2A2721);
  static const darkPrimary = Color(0xFF8A7650);
  static const darkSecondary = Color(0xFFA89263);
  static const darkTextPrimary = Color(0xFFF5F1DE);
  static const darkTextSecondary = Color(0xFFCFC8B0);
  static const darkBorder = Color(0xFF3A362F);

  static const error = Color(0xFFE57373);
  static const success = Color(0xFF7FAF63);
  static const warning = Color(0xFFE0B94F);
  static const info = Color(0xFF81B5B6);
}

class AppCustomColors extends ThemeExtension<AppCustomColors> {
  final Color success;
  final Color warning;
  final Color info;

  const AppCustomColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  @override
  ThemeExtension<AppCustomColors> copyWith({
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return AppCustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<AppCustomColors> lerp(
    covariant ThemeExtension<AppCustomColors>? other,
    double t,
  ) {
    if (other is! AppCustomColors) return this;
    return AppCustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static final ThemeData light = _buildTheme(
    brightness: Brightness.light,
    primary: AppColors.lightPrimary,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    border: AppColors.lightBorder,
  );

  static final ThemeData dark = _buildTheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    border: AppColors.darkBorder,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primary,
    required Color background,
    required Color surface,
    required Color textPrimary,
    required Color textSecondary,
    required Color border,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'TT Commons',
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        secondary: primary.withAlpha(190),
        surface: surface,
        error: AppColors.error,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: textPrimary,
        onSurface: textPrimary,
      ),
      scaffoldBackgroundColor: background,
      extensions: [
        const AppCustomColors(
          success: AppColors.success,
          warning: AppColors.warning,
          info: AppColors.info,
        ),
      ],
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(primary),
          foregroundColor: WidgetStateProperty.all(
            isDark ? background : Colors.white,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white12 : Colors.black12,
      ),
      iconTheme: IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    );
  }
}
