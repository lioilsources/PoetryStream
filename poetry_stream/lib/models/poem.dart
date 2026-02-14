import '../core/utils/stanza_parser.dart';

class Poem {
  final String id;
  final String title;
  final String author;
  final String fullText;
  final String collectionId;
  final int sortOrder;

  const Poem({
    required this.id,
    this.title = '',
    this.author = '',
    required this.fullText,
    this.collectionId = 'default',
    this.sortOrder = 0,
  });

  List<String> get stanzas => splitIntoStanzas(fullText);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'fullText': fullText,
        'collectionId': collectionId,
        'sortOrder': sortOrder,
      };

  factory Poem.fromJson(Map<String, dynamic> json) => Poem(
        id: json['id'] as String,
        title: (json['title'] as String?) ?? '',
        author: (json['author'] as String?) ?? '',
        fullText: json['fullText'] as String,
        collectionId: (json['collectionId'] as String?) ?? 'default',
        sortOrder: (json['sortOrder'] as int?) ?? 0,
      );
}
