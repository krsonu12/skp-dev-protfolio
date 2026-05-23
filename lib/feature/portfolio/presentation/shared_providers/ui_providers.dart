import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic hover state provider — override per widget using ProviderScope.
final hoverProvider = StateProvider<bool>((ref) => false);

/// Generic visibility state provider — override per widget using ProviderScope.
final visibilityProvider = StateProvider<bool>((ref) => false);

/// Active nav section index (-1 = hero/top).
final activeSectionProvider = StateProvider<int>((ref) => -1);
