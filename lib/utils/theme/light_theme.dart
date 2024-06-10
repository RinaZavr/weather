part of 'theme.dart';

class LightTheme {
  ThemeData lightTheme() {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 45,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          color: AppColors.grey,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.grey,
        selectedItemColor: AppColors.yellow,
        unselectedItemColor: AppColors.darkGrey,
      ),
      primaryColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.black),
    );
  }
}
