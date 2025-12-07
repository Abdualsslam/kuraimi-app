import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController userIdController;
  final TextEditingController passwordController;

  const LoginForm({super.key, required this.userIdController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Column(
      children: [
        CustomTextField(
          label: s.userIdLabel,
          hint: s.userIdHint,
          controller: userIdController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return s.userIdRequired;
            }
            return null;
          },
        ),
        SizedBox(height: 25.h),
        CustomTextField(
          label: s.passwordLabel,
          hint: s.passwordHint,
          isPassword: true,
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return s.passwordRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
