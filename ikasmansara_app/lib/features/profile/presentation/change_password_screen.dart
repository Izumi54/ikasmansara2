import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ikasmansara_app/common_widgets/buttons/primary_button.dart';
import 'package:ikasmansara_app/common_widgets/inputs/custom_text_field.dart';
import 'package:ikasmansara_app/core/utils/validators.dart';
import 'package:ikasmansara_app/features/auth/presentation/providers/auth_providers.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authRepositoryProvider)
          .changePassword(
            oldPassword: _oldPasswordController.text,
            newPassword: _newPasswordController.text,
            confirmPassword: _confirmPasswordController.text,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password berhasil diubah.'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengubah password: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Password Lama',
                controller: _oldPasswordController,
                isPassword: true,
                validator: Validators.required,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password Baru',
                controller: _newPasswordController,
                isPassword: true,
                validator: Validators.password,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Konfirmasi Password Baru',
                controller: _confirmPasswordController,
                isPassword: true,
                validator: (val) {
                  if (val != _newPasswordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Simpan Password Baru',
                onPressed: _submit,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
