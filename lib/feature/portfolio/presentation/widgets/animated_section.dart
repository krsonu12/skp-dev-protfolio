import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades + slides in when scrolled into view.
/// Uses [ValueNotifier] — zero [setState].
class AnimatedSection extends StatelessWidget {
  const AnimatedSection({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Each instance gets its own notifier via the key.
    final visible = ValueNotifier<bool>(false);

    return VisibilityDetector(
      key: key ?? UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !visible.value) {
          visible.value = true;
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: visible,
        builder: (context, isVisible, _) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 600),
            opacity: isVisible ? 1.0 : 0.0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              offset: isVisible ? Offset.zero : const Offset(0, 0.05),
              curve: Curves.easeOutCubic,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
