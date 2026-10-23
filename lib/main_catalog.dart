import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'catalog/catalog_app.dart';

/// The widget catalog (a storybook of the components), apart from the app:
///   flutter run --flavor dev -t lib/main_catalog.dart
void main() {
  startCatalog();
  // the scope lets a story show a component that reads a provider
  runApp(const ProviderScope(child: CatalogApp()));
}
