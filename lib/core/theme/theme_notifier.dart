import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeModeKey = 'theme_mode';

/// Persists and exposes the current [ThemeMode].
/// Reads the saved preference on first build; defaults to [ThemeMode.dark].
class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeModeKey);
    return _fromString(saved);
  }

  Future<void> setMode(ThemeMode mode) async {
    state = AsyncData(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeModeKey, _toString(mode));
  }

  Future<void> toggle() async {
    final current = state.valueOrNull ?? ThemeMode.dark;
    await setMode(current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  // ── helpers ───────────────────────────────────────────────────────────────
  static ThemeMode _fromString(String? value) => switch (value) {
        'light' => ThemeMode.light,
        'system' => ThemeMode.system,
        _ => ThemeMode.dark,
      };

  static String _toString(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.system => 'system',
        ThemeMode.dark => 'dark',
      };
}

final themeNotifierProvider =
    AsyncNotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);
