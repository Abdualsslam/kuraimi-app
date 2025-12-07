import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/app_text_styles.dart';
import '../themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool showCounter;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.showCounter = false,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  bool _isFocused = false;
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _focusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
    });

    if (hasFocus) {
      _animationController.forward();
      HapticFeedback.lightImpact();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // التسمية
        // AnimatedContainer(
        //   duration: const Duration(milliseconds: 200),
        //   child: Text(
        //     widget.label,
        //     style: AppTextStyles.inputLabel.copyWith(color: _isFocused ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.7)),
        //   ),
        // ),
        // const SizedBox(height: 8),

        // الحقل
        AnimatedBuilder(
          animation: _focusAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(_isFocused ? 0.15 * _focusAnimation.value : 0.05),
                    blurRadius: 10 + (5 * _focusAnimation.value),
                    offset: Offset(0, 2 + (3 * _focusAnimation.value)),
                  ),
                ],
              ),
              child: Focus(
                onFocusChange: _handleFocusChange,
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.isPassword ? _obscureText : false,
                  validator: widget.validator,
                  textAlign: TextAlign.right,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  enabled: widget.enabled,
                  maxLines: widget.isPassword ? 1 : widget.maxLines,
                  minLines: widget.minLines,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  readOnly: widget.readOnly,
                  maxLength: widget.maxLength,
                  style: AppTextStyles.inputText.copyWith(
                    color: widget.enabled ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.5),
                  ),
                  decoration: InputDecoration(
                    // الليبل داخل الحقل
                    labelText: widget.label,

                    // خلّيه دائمًا فوق البوردر (أو استخدم auto عشان يطفو عند الكتابة/التركيز فقط)
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    // في Flutter حديث تقدر تتحكم بالمحاذاة (يتكيّف مع RTL تلقائيًا)
                    floatingLabelAlignment: FloatingLabelAlignment.start,

                    labelStyle: AppTextStyles.inputLabel.copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
                    floatingLabelStyle: AppTextStyles.inputLabel.copyWith(color: AppColors.secondaryColor, fontSize: 18),
                    // الهنت
                    hintText: widget.hint,
                    hintStyle: AppTextStyles.inputHint.copyWith(color: colorScheme.onSurface.withOpacity(0.5)),

                    // الخلفية والحدود
                    filled: true,
                    fillColor: _isFocused ? colorScheme.surface : colorScheme.surface.withOpacity(0.8),

                    border: _buildBorder(colorScheme.outline),
                    enabledBorder: _buildBorder(colorScheme.outline.withOpacity(0.5)),
                    focusedBorder: _buildBorder(colorScheme.primary),
                    errorBorder: _buildBorder(colorScheme.error),
                    focusedErrorBorder: _buildBorder(colorScheme.error),
                    disabledBorder: _buildBorder(colorScheme.outline.withOpacity(0.3)),

                    // مهم: مساحة داخلية كافية تحت الليبل
                    // زوّد الـ top قليلًا عشان ما يتداخل النص مع الليبل العائم
                    contentPadding: const EdgeInsets.fromLTRB(20, 24, 20, 8),

                    prefixIcon: widget.prefixIcon,
                    suffixIcon: _buildSuffixIcon(colorScheme),

                    errorStyle: AppTextStyles.inputError.copyWith(color: colorScheme.error, inherit: true),

                    // العداد
                    counterText: widget.showCounter ? null : '',
                    counterStyle: AppTextStyles.bodySmall.copyWith(color: colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color, width: _isFocused ? 2.5 : 2),
    );
  }

  Widget? _buildSuffixIcon(ColorScheme colorScheme) {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.isPassword) {
      return IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            key: ValueKey(_obscureText),
            color: _isFocused ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
          HapticFeedback.lightImpact();
        },
        splashRadius: 20,
      );
    }

    return null;
  }
}
