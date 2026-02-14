class PoemCollection {
  final String id;
  final String title;
  final String description;
  final bool isFree;
  final String? productId;
  final int poemCount;

  const PoemCollection({
    required this.id,
    required this.title,
    this.description = '',
    this.isFree = false,
    this.productId,
    this.poemCount = 0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isFree': isFree,
        'productId': productId,
        'poemCount': poemCount,
      };

  factory PoemCollection.fromJson(Map<String, dynamic> json) =>
      PoemCollection(
        id: json['id'] as String,
        title: json['title'] as String,
        description: (json['description'] as String?) ?? '',
        isFree: (json['isFree'] as bool?) ?? false,
        productId: json['productId'] as String?,
        poemCount: (json['poemCount'] as int?) ?? 0,
      );
}
