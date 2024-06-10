part of 'theme.dart';

class DarkTheme {
  ThemeData darkTheme() {
    return ThemeData(
      primaryColor: Colors.black,
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
        displaySmall: TextStyle(color: AppColors.yellow, fontSize: 15),
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkGrey,
        selectedItemColor: AppColors.yellow,
        unselectedItemColor: AppColors.grey,
      ),
      dialogBackgroundColor: AppColors.darkGrey,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.darkGrey),
    );
  }
}
