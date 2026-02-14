import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../core/constants/defaults.dart';
import '../core/utils/stanza_parser.dart';
import '../models/poem.dart';

const _uuid = Uuid();

class PoemListNotifier extends StateNotifier<List<Poem>> {
  PoemListNotifier() : super(_buildDefaultPoems());

  static List<Poem> _buildDefaultPoems() {
    return defaultPoems.asMap().entries.map((entry) {
      return Poem(
        id: 'default_${entry.key}',
        fullText: entry.value,
        collectionId: 'default',
        sortOrder: entry.key,
      );
    }).toList();
  }

  void addUserPoem(String text) {
    final stanzas = splitIntoStanzas(text);
    if (stanzas.isEmpty) return;

    state = [
      ...state,
      Poem(
        id: _uuid.v4(),
        fullText: text.trim(),
        collectionId: 'user',
        sortOrder: state.length,
      ),
    ];
  }

  void addPoemsFromCollection(List<Poem> poems) {
    state = [...state, ...poems];
  }

  void removePoem(String id) {
    state = state.where((p) => p.id != id).toList();
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
