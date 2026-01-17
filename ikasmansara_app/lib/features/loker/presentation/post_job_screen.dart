import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PostJobScreen extends StatelessWidget {
  const PostJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pasang Lowongan'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Fitur Pasang Lowongan akan segera hadir!'),
      ),
    );
  }
}
