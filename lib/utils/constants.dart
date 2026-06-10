import 'package:flutter/material.dart';

/// Constants - File untuk menyimpan konstanta yang digunakan di seluruh aplikasi
class AppConstants {
  // App Info
  static const String appName = 'catat.in';
  static const String appTagline = 'Daftar untuk mulai mencatat.';
  static const String loginTagline = 'Masuk untuk mulai mencatat.';

  // Categories
  static const List<String> categories = [
    'Semua',
    'Kuliah',
    'Kerja',
    'Pribadi',
  ];

  // Sort Options
  static const List<String> sortOptions = [
    'Latest',
    'Oldest',
    'A-Z',
    'Z-A',
  ];

  // About Us Data
  static const List<Map<String, String>> creators = [
    {
      'name': 'Danang Adiwibowo',
      'photo': 'assets/danankmobile.jpeg',
    },
    {
      'name': 'Gorga Doli Liberto Napitupulu',
      'photo': 'assets/gorokmobile.jpeg',
    },
  ];
}

/// AppColors - Color palette dari design Figma
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF0061A4);
  static const Color background = Color(0xFFF8F9FF);
  static const Color white = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF404752);
  static const Color textSecondary = Color(0xFF707883);
  static const Color textPlaceholder = Color(0xFF707883);

  // Border Colors
  static const Color border = Color(0xFFBFC7D4);
  static const Color borderError = Colors.red;

  // Category Colors
  static const Color categoryKuliah = Color(0xFF4CAF50);
  static const Color categoryKerja = Color(0xFFFF9800);
  static const Color categoryPribadi = Color(0xFF9C27B0);
  static const Color categorySemua = Color(0xFF2196F3);

  // Helper method untuk mendapatkan warna kategori
  static Color getCategoryColor(String category) {
    switch (category) {
      case 'Kuliah':
        return categoryKuliah;
      case 'Kerja':
        return categoryKerja;
      case 'Pribadi':
        return categoryPribadi;
      default:
        return categorySemua;
    }
  }
}

/// AppTextStyles - Text styles dari design Figma
class AppTextStyles {
  // Title Style (catat.in logo)
  static const TextStyle title = TextStyle(
    color: AppColors.primary,
    fontSize: 32,
    fontFamily: 'Hanken Grotesk',
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.64,
  );

  // Subtitle
  static const TextStyle subtitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 1.43,
  );

  // Label
  static const TextStyle label = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  // Input Text
  static const TextStyle input = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );

  // Button Text
  static const TextStyle button = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );

  // Body Text
  static const TextStyle body = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );

  // Note Title
  static const TextStyle noteTitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );

  // Note Content
  static const TextStyle noteContent = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
}
