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
        displaySmall: TextStyle(
          color: AppColors.accentLightTheme,
          fontSize: 15,
        ),
      ),
      
      hintColor: AppColors.darkAccentLightTheme,
      primaryColor: Colors.white,
      primaryColorLight: AppColors.accentLightTheme,
      primaryColorDark: AppColors.darkWhite,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkWhite,
        selectedItemColor: AppColors.accentLightTheme,
        unselectedItemColor: AppColors.darkGrey,
      ),
      dialogBackgroundColor: Colors.white,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.black),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(4),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintStyle: TextStyle(
          color: AppColors.darkGrey,
          fontSize: 15,
        ),
        fillColor: AppColors.darkWhite,
        filled: true,
      ),
    );
  }
}
