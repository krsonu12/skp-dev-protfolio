import 'package:flutter/material.dart';

/// Maps logical icon keys (stored in domain entities) to Flutter [IconData].
/// This is the only place in the presentation layer that knows about icon codes.
class IconResolver {
  IconResolver._();

  static const _map = <String, IconData>{
    // Projects
    'label_outline': Icons.label_outline,
    'local_hospital_outlined': Icons.local_hospital_outlined,
    'local_shipping_outlined': Icons.local_shipping_outlined,
    'shopping_cart_outlined': Icons.shopping_cart_outlined,
    'phone_android': Icons.phone_android,
    // Skills
    'account_tree_outlined': Icons.account_tree_outlined,
    'bolt_outlined': Icons.bolt_outlined,
    'language_outlined': Icons.language_outlined,
    'cloud_outlined': Icons.cloud_outlined,
    'rocket_launch_outlined': Icons.rocket_launch_outlined,
    'science_outlined': Icons.science_outlined,
    'storage_outlined': Icons.storage_outlined,
    'build_outlined': Icons.build_outlined,
  };

  static IconData resolve(String key) => _map[key] ?? Icons.code_outlined;
}
