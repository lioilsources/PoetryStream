import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import '../../models/poem.dart';
import '../../models/poem_collection.dart';

/// All paid collections available for purchase.
const List<PoemCollection> availableCollections = [
  PoemCollection(
    id: 'f01',
    title: 'Simon Cline',
    description: 'PRAVDU MÁ JEN JEDEN ANEB V ZORNÉM POLI MINISTERSTVA LÁSKY',
    isFree: false,
    productId: 'poetrystream_collection_pravdu_ma_jen_jeden',
    poemCount: 13,
  ),
  
];

/// Map product ID (from store) → collection ID (internal).
final Map<String, String> productIdToCollectionId = {
  for (final c in availableCollections)
    if (c.productId != null) c.productId!: c.id,
};

/// All product IDs to query from the store.
final Set<String> allProductIds = {
  for (final c in availableCollections)
    if (c.productId != null) c.productId!,
};

/// Load poems for a collection from its YAML asset file.
Future<List<Poem>> loadCollectionPoems(String collectionId) async {
  try {
    final yamlString =
        await rootBundle.loadString('assets/poems/$collectionId.yaml');
    final yamlList = loadYaml(yamlString) as YamlList;

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
    // Asset missing or parse error — return empty
    return [];
  }
}
