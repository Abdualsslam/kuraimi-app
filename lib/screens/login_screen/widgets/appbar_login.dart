import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../providers/theme_cubit.dart';
import '../../../constants/assets.dart';

class AppBarLogin extends StatelessWidget {
  const AppBarLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return Column(
      children: [
        // const SizedBox(height: 20),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Image.asset(
            Assets.iconTitle,
            width: 290.w,
            color: isDarkMode ? Colors.white : Theme.of(context).colorScheme.primary,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
