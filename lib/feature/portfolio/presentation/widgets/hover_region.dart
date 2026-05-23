import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared_providers/ui_providers.dart';

/// Wraps [child] with hover detection backed by a scoped [hoverProvider].
/// The [builder] receives the current hover state.
/// Zero [setState] — all state lives in Riverpod.
class HoverRegion extends ConsumerWidget {
  const HoverRegion({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.click,
  });

  final Widget Function(BuildContext context, WidgetRef ref, bool hovered)
      builder;
  final MouseCursor cursor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Each HoverRegion gets its own isolated hoverProvider via ProviderScope.
    return ProviderScope(
      overrides: [hoverProvider.overrideWith((ref) => false)],
      child: _HoverRegionInner(builder: builder, cursor: cursor),
    );
  }
}

class _HoverRegionInner extends ConsumerWidget {
  const _HoverRegionInner({required this.builder, required this.cursor});

  final Widget Function(BuildContext, WidgetRef, bool) builder;
  final MouseCursor cursor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hovered = ref.watch(hoverProvider);

    return MouseRegion(
      cursor: cursor,
      onEnter: (_) => ref.read(hoverProvider.notifier).state = true,
      onExit: (_) => ref.read(hoverProvider.notifier).state = false,
      child: builder(context, ref, hovered),
    );
  }
}
