import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_strings.dart';

class OptionsSection extends StatefulWidget {
  const OptionsSection({super.key});

  @override
  State<OptionsSection> createState() => _OptionsSectionState();
}

class _OptionsSectionState extends State<OptionsSection> {
  bool _isOfflineLoginChecked = false;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Theme.of(context).colorScheme.primary.withOpacity(.32);
                  }
                  return Theme.of(context).colorScheme.background;
                }),
                checkColor: Theme.of(context).colorScheme.secondary,
                side: WidgetStateBorderSide.resolveWith((states) => BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
                value: _isOfflineLoginChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isOfflineLoginChecked = value ?? false;
                  });
                },
              ),
              Flexible(
                child: Text(
                  s.offlineLogin,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w300, fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _showForgotPasswordDialog(context);
            },
            child: Text(
              s.forgotPassword,
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w300, fontSize: 12.sp),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final s = AppStrings.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          title: Row(
            children: [
              Icon(Icons.help_outline, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: 12.w),
              Text(s.forgotPasswordTitle),
            ],
          ),
          content: Text(s.forgotPasswordContent, style: TextStyle(height: 1.5)),
          actions: [
            GestureDetector(onTap: () => Navigator.of(context).pop(), child: Text(s.close)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Call customer service
                _callCustomerService(context);
              },
              child: Text(s.contactSupport),
            ),
          ],
        );
      },
    );
  }

  void _callCustomerService(BuildContext context) {
    final s = AppStrings.of(context);
    // تنفيذ الاتصال بخدمة العملاء
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.callingCustomerService),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
