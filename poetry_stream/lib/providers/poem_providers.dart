import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';
import '../core/utils/stanza_parser.dart';
import '../models/poem.dart';

const _uuid = Uuid();

class PoemListNotifier extends StateNotifier<List<Poem>> {
  PoemListNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final bundled = await _loadBundledPoems();
    final purchased = await _loadPurchasedPoems();
    final user = await _loadUserPoems();
    state = [...bundled, ...purchased, ...user];
    if (state.isEmpty) {
      debugPrint('PoemListNotifier: no poems loaded, check assets/poems/default.yaml');
    }
  }

  /// Reload all poems (called after a purchase unlocks new content).
  void refresh() => _load();

  static Future<List<Poem>> _loadBundledPoems() async {
    try {
      final yamlString =
          await rootBundle.loadString('assets/poems/default.yaml');
      final yamlList = loadYaml(yamlString) as YamlList;

      return yamlList.asMap().entries.map((entry) {
        final item = entry.value as YamlMap;
        return Poem(
          id: 'default_${entry.key}',
          title: (item['title'] as String?) ?? '',
          fullText: (item['text'] as String).trimRight(),
          collectionId: 'default',
          sortOrder: entry.key,
        );
      }).toList();
    } catch (e) {
      debugPrint('Failed to load bundled poems: $e');
      return [];
    }
  }

  static Future<List<Poem>> _loadPurchasedPoems() async {
    final box = await Hive.openBox('purchased_poems');
    final List<Poem> all = [];
    for (final key in box.keys) {
      final raw = box.get(key);
      if (raw == null) continue;
      try {
        final list = (jsonDecode(raw as String) as List)
            .map((e) => Poem.fromJson(e as Map<String, dynamic>))
            .toList();
        all.addAll(list);
      } catch (_) {
        // Skip corrupted data
      }
    }
    return all;
  }

  static Future<List<Poem>> _loadUserPoems() async {
    try {
      final box = await Hive.openBox('poems');
      final raw = box.get('user_poems');
      if (raw == null) return [];

      final list = (jsonDecode(raw as String) as List)
          .map((e) => Poem.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      debugPrint('Failed to load user poems: $e');
      return [];
    }
  }

  Future<void> _saveUserPoems() async {
    final box = await Hive.openBox('poems');
    final userPoems = state.where((p) => p.collectionId == 'user').toList();
    await box.put('user_poems', jsonEncode(userPoems.map((p) => p.toJson()).toList()));
  }

  void addUserPoem(String title, String text) {
    final stanzas = splitIntoStanzas(text);
    if (stanzas.isEmpty) return;

    state = [
      ...state,
      Poem(
        id: _uuid.v4(),
        title: title,
        fullText: text.trim(),
        collectionId: 'user',
        sortOrder: state.length,
      ),
    ];
    _saveUserPoems();
  }

  void removePoem(String id) {
    state = state.where((p) => p.id != id).toList();
    _saveUserPoems();
  }
}

final poemListProvider =
    StateNotifierProvider<PoemListNotifier, List<Poem>>((ref) {
  return PoemListNotifier();
});

final allStanzasProvider = Provider<List<String>>((ref) {
  final poems = ref.watch(poemListProvider);
  return poems.expand((p) => p.stanzas).toList();
});

final stanzaCountProvider = Provider<int>((ref) {
  return ref.watch(allStanzasProvider).length;
});
