import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// AboutPage - Halaman Tentang Kami
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back button
        title: const Text(
          'Tentang Kami',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            
            // App Description
            const Text(
              'Aplikasi catatan sederhana untuk menyimpan ide dan gagasan Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            
            // About Description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Aplikasi',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'catat.in hadir sebagai solusi praktis untuk mencatat berbagai hal penting dalam keseharian. '
                    'Aplikasi ini kami kembangkan dengan tujuan memudahkan mahasiswa, pekerja, dan siapa saja '
                    'yang membutuhkan tempat menyimpan catatan secara terorganisir.\n\n'
                    'Dengan fitur kategorisasi (Kuliah, Kerja, Pribadi), pencarian, dan pengurutan catatan, '
                    'diharapkan catat.in bisa membantu pengguna mengelola informasi dengan lebih efisien. '
                    'Aplikasi ini dikembangkan menggunakan Flutter dengan database SQLite untuk memastikan '
                    'data tersimpan dengan aman di perangkat masing-masing.\n\n'
                    'Kami berharap catat.in dapat menjadi teman setia dalam mencatat setiap ide, tugas, '
                    'dan hal penting lainnya. Terima kasih telah menggunakan aplikasi ini!',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Divider
            const Divider(),
            const SizedBox(height: 16),
            
            // Creators Section
            const Text(
              'Dibuat Oleh:',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            
            // Creators List
            ...AppConstants.creators.map((creator) => _buildCreatorCard(creator)),
            
            const SizedBox(height: 32),
            
            // Tech Stack Section
            const Divider(),
            const SizedBox(height: 16),
            
            const Text(
              'Tech Stack',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Tech Stack Cards
            _buildTechStackCard(
              imagePath: 'assets/flutterpng.png',
              title: 'Flutter',
              description: 'Framework UI cross-platform',
            ),
            const SizedBox(height: 12),
            _buildTechStackCard(
              imagePath: 'assets/dartpng.png',
              title: 'Dart',
              description: 'Bahasa pemrograman',
            ),
            const SizedBox(height: 12),
            _buildTechStackCard(
              imagePath: 'assets/sqlitepng.png',
              title: 'SQLite',
              description: 'Database lokal',
            ),
            const SizedBox(height: 12),
            _buildTechStackCard(
              icon: Icons.view_list_rounded,
              title: 'MVC Pattern',
              description: 'Arsitektur aplikasi',
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatorCard(Map<String, String> creator) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Photo from assets
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(creator['photo'] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creator['name'] ?? '',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Developer',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStackCard({
    IconData? icon,
    String? imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Icon or Image
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: imagePath != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  )
                : Icon(
                    icon,
                    color: AppColors.primary,
                    size: 28,
                  ),
          ),
          const SizedBox(width: 16),
          
          // Title & Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
