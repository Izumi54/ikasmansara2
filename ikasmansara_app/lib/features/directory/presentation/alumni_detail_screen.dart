import 'package:flutter/material.dart';
import 'package:ikasmansara_app/core/theme/app_colors.dart';
import 'package:ikasmansara_app/core/theme/app_text_styles.dart';
import 'package:ikasmansara_app/features/directory/domain/entities/alumni_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class AlumniDetailScreen extends StatelessWidget {
  final AlumniEntity alumni;

  const AlumniDetailScreen({super.key, required this.alumni});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil Alumni'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        titleTextStyle: AppTextStyles.h3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar Center
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                backgroundImage: alumni.avatar != null
                    ? NetworkImage(alumni.avatar!)
                    : NetworkImage(
                        'https://ui-avatars.com/api/?name=${alumni.name.replaceAll(' ', '+')}&size=256',
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Name & Batch
            Text(
              alumni.name,
              style: AppTextStyles.h2.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Angkatan ${alumni.angkatan}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Info Cards
            _buildInfoCard(
              icon: Icons.work,
              title: 'Pekerjaan',
              content: alumni.fullJobTitle,
            ),
            if (alumni.domicile != null) ...[
              const SizedBox(height: 16),
              _buildInfoCard(
                icon: Icons.location_on,
                title: 'Domisili',
                content: alumni.domicile!,
              ),
            ],
            const SizedBox(height: 16),
            _buildInfoCard(
              icon: Icons.email,
              title: 'Email',
              content: alumni.email,
              onTap: () {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: alumni.email,
                );
                launchUrl(emailLaunchUri);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: onTap != null ? AppColors.primary : Colors.black87,
                      decoration: onTap != null
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
