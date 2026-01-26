import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ikasmansara_app/core/theme/app_colors.dart';
import 'package:ikasmansara_app/core/theme/app_text_styles.dart';
import 'package:ikasmansara_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:ikasmansara_app/features/profile/presentation/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan'), centerTitle: true),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader('Akun'),
          _buildSettingsItem(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profil',
            onTap: () => context.push('/profile/edit'),
          ),
          _buildSettingsItem(
            context,
            icon: Icons.lock_outline,
            title: 'Ubah Password',
            onTap: () {
              context.push('/profile/settings/change-password');
            },
          ),

          const SizedBox(height: 16),
          _buildSectionHeader('Aplikasi'),
          Consumer(
            builder: (context, ref, child) {
              final notificationsAsync = ref.watch(settingsControllerProvider);
              return _buildSettingsItem(
                context,
                icon: Icons.notifications_outlined,
                title: 'Notifikasi',
                trailing: notificationsAsync.when(
                  data: (isEnabled) => Switch(
                    value: isEnabled,
                    onChanged: (val) {
                      ref
                          .read(settingsControllerProvider.notifier)
                          .toggleNotifications(val);
                    },
                    activeColor: AppColors.primary,
                  ),
                  loading: () => const SizedBox(
                    width: 40,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Icon(Icons.error, color: Colors.grey),
                ),
              );
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.dark_mode_outlined,
            title: 'Tema Gelap',
            trailing: Switch(
              value: false,
              onChanged: (val) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fitur Tema Gelap akan segera hadir.'),
                  ),
                );
              },
            ),
          ),
          _buildSettingsItem(
            context,
            icon: Icons.language,
            title: 'Bahasa',
            subtitle: 'Bahasa Indonesia',
            onTap: () {},
          ),

          const SizedBox(height: 16),
          _buildSectionHeader('Tentang'),
          _buildSettingsItem(
            context,
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'IKA SMANSARA',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.school,
                  size: 50,
                  color: AppColors.primary,
                ),
                children: [
                  const Text('Aplikasi Jejaring Alumni SMA Negeri 1 Jepara.'),
                ],
              );
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Kebijakan Privasi',
            onTap: () {},
          ),

          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text(
                      'Apakah Anda yakin ingin keluar dari aplikasi?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          ref.read(authRemoteDataSourceProvider).logout();
                          context.go('/login');
                        },
                        child: const Text(
                          'Keluar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Keluar / Logout',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Versi 1.0.0 (Build 20260126)',
              style: AppTextStyles.caption.copyWith(color: AppColors.textGrey),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textGrey),
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: subtitle != null
          ? Text(subtitle, style: AppTextStyles.caption)
          : null,
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
