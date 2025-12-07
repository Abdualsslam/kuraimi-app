import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/assets.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final String? semanticsLabel;

  const LoadingIndicator({Key? key, this.size = 48, this.color, this.semanticsLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color effective = color ?? Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        Assets.iconLoadingJson,
        fit: BoxFit.contain,
        delegates: LottieDelegates(
          values: [
            ValueDelegate.color(['**'], value: effective),
          ],
        ),
        frameRate: FrameRate.max,
        repeat: true,
        animate: true,
        options: LottieOptions(enableMergePaths: true),
        // semanticsLabel is available in Lottie 2.x
      ),
    );
  }
}
