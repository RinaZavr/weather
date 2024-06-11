part of 'theme.dart';

class DarkTheme {
  ThemeData darkTheme() {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 45,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          color: AppColors.grey,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        displaySmall: TextStyle(
          color: AppColors.accentDarkTheme,
          fontSize: 15,
        ),
      ),
      hintColor: AppColors.darkAccentDarkTheme,
      primaryColor: Colors.black,
      primaryColorLight: AppColors.accentDarkTheme,
      primaryColorDark: AppColors.darkGrey,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkGrey,
        selectedItemColor: AppColors.accentDarkTheme,
        unselectedItemColor: AppColors.grey,
      ),
      dialogBackgroundColor: AppColors.darkGrey,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.darkGrey),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(4),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintStyle: TextStyle(
          color: AppColors.grey,
          fontSize: 15,
        ),
        fillColor: AppColors.darkGrey,
        filled: true,
      ),
    );
  }
}
