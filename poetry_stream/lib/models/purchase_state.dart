import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseState {
  final Set<String> unlockedCollectionIds;
  final Map<String, ProductDetails> products;
  final bool isAvailable;
  final bool isLoading;
  final bool isRestoring;
  final String? errorMessage;

  const PurchaseState({
    this.unlockedCollectionIds = const {},
    this.products = const {},
    this.isAvailable = false,
    this.isLoading = true,
    this.isRestoring = false,
    this.errorMessage,
  });

  bool isUnlocked(String collectionId) =>
      unlockedCollectionIds.contains(collectionId);

  PurchaseState copyWith({
    Set<String>? unlockedCollectionIds,
    Map<String, ProductDetails>? products,
    bool? isAvailable,
    bool? isLoading,
    bool? isRestoring,
    String? Function()? errorMessage,
  }) {
    return PurchaseState(
      unlockedCollectionIds:
          unlockedCollectionIds ?? this.unlockedCollectionIds,
      products: products ?? this.products,
      isAvailable: isAvailable ?? this.isAvailable,
      isLoading: isLoading ?? this.isLoading,
      isRestoring: isRestoring ?? this.isRestoring,
      errorMessage:
          errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
