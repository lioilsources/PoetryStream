import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import '../../models/poem.dart';
import '../../models/poem_collection.dart';

/// Dynamický seznam placených sbírek — naplněn při startu z YAML assetů.
var availableCollections = <PoemCollection>[];

/// Map product ID (from store) → collection ID (internal).
Map<String, String> get productIdToCollectionId => {
      for (final c in availableCollections)
        if (c.productId != null) c.productId!: c.id,
    };

/// All product IDs to query from the store.
Set<String> get allProductIds => {
      for (final c in availableCollections)
        if (c.productId != null) c.productId!,
    };

/// Načte a zaregistruje všechny placené sbírky z assets/poems/*.yaml.
/// YAML soubory s klíčem `product_id` jsou považovány za placené.
/// Volat při startu app před runApp().
Future<void> initializeCollections() async {
  final manifestJson = await rootBundle.loadString('AssetManifest.json');
  final manifest = jsonDecode(manifestJson) as Map<String, dynamic>;

  final poemPaths = manifest.keys
      .where((k) => k.startsWith('assets/poems/') && k.endsWith('.yaml'))
      .toList()
    ..sort();

  final discovered = <PoemCollection>[];
  for (final path in poemPaths) {
    final filename = path.split('/').last;
    final collectionId = filename.substring(0, filename.length - 5);
    if (collectionId == 'default') continue;

    try {
      final yamlString = await rootBundle.loadString(path);
      final doc = loadYaml(yamlString);
      if (doc is YamlMap && doc['product_id'] != null) {
        discovered.add(PoemCollection(
          id: collectionId,
          title: (doc['title'] as String?) ?? collectionId,
          isFree: false,
          productId: doc['product_id'] as String,
          poemCount: (doc['poems'] as YamlList?)?.length ?? 0,
        ));
      }
    } catch (_) {}
  }
  availableCollections = discovered;
}

/// Vrátí zobrazitelný název sbírky podle jejího ID.
String collectionDisplayTitle(String collectionId) {
  if (collectionId == 'user') return 'Moje básně';
  if (collectionId == 'default') return 'PRAVDU MÁ JEN JEDEN';
  return availableCollections
      .firstWhere(
        (c) => c.id == collectionId,
        orElse: () => PoemCollection(id: collectionId, title: collectionId),
      )
      .title;
}

/// Načte básně pro sbírku z jejího YAML asset souboru.
/// Podporuje plain list formát (default.yaml) i map formát s klíčem `poems`.
Future<List<Poem>> loadCollectionPoems(String collectionId) async {
  try {
    final yamlString =
        await rootBundle.loadString('assets/poems/$collectionId.yaml');
    final doc = loadYaml(yamlString);
    final YamlList yamlList =
        doc is YamlMap ? doc['poems'] as YamlList : doc as YamlList;

    return yamlList.asMap().entries.map((entry) {
      final item = entry.value as YamlMap;
      return Poem(
        id: '${collectionId}_${entry.key}',
        title: (item['title'] as String?) ?? '',
        author: (item['author'] as String?) ?? '',
        fullText: (item['text'] as String).trimRight(),
        collectionId: collectionId,
        sortOrder: entry.key,
      );
    }).toList();
  } catch (e) {
    return [];
  }
}
