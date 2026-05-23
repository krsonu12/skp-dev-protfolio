import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Asset paths for all Lottie animations used in the portfolio.
class LottieAssets {
  LottieAssets._();
  static const String coding = 'assets/lottie/coding.json';
  static const String rocket = 'assets/lottie/rocket.json';
  static const String hello = 'assets/lottie/hello.json';
  static const String skills = 'assets/lottie/skills.json';
}

/// A Lottie animation loaded from assets with graceful error fallback.
/// Loops by default; pass [repeat] = false for one-shot animations.
class LottieWidget extends StatelessWidget {
  const LottieWidget({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.repeat = true,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.filterQuality = FilterQuality.medium,
  });

  final String asset;
  final double? width;
  final double? height;
  final bool repeat;
  final BoxFit fit;
  final Alignment alignment;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      asset,
      width: width,
      height: height,
      repeat: repeat,
      fit: fit,
      alignment: alignment,
      filterQuality: filterQuality,
      errorBuilder: (context, error, stack) => const SizedBox.shrink(),
      frameBuilder: (context, child, composition) {
        // Fade in once the composition is loaded
        if (composition == null) return const SizedBox.shrink();
        return child;
      },
    );
  }
}
