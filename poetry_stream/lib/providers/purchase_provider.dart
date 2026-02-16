import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../data/purchase/purchase_service.dart';
import '../data/repositories/collection_repository.dart';
import '../models/purchase_state.dart';
import 'poem_providers.dart';

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  final Ref _ref;

  PurchaseNotifier(this._ref) : super(const PurchaseState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    // Start listening to purchase stream
    await PurchaseService.instance.initialize(
      onPurchaseUpdate: _handlePurchaseUpdate,
    );

    // Load previously unlocked collections from Hive
    final unlocked = await _loadUnlockedIds();

    // Check store availability
    final available = await PurchaseService.instance.isAvailable();

    if (!available) {
      state = state.copyWith(
        isAvailable: false,
        isLoading: false,
        unlockedCollectionIds: unlocked,
      );
      return;
    }

    // Query product details (prices etc.)
    Map<String, ProductDetails> products = {};
    try {
      final response =
          await PurchaseService.instance.queryProducts(allProductIds);
      products = {
        for (final p in response.productDetails) p.id: p,
      };
    } catch (_) {
      // Store query failed — continue with empty products
    }

    state = state.copyWith(
      isAvailable: true,
      isLoading: false,
      unlockedCollectionIds: unlocked,
      products: products,
    );

    // Restore purchases if Hive was empty (fresh install / cleared data)
    if (unlocked.isEmpty) {
      await restorePurchases();
    }
  }

  Future<void> purchaseCollection(ProductDetails product) async {
    try {
      await PurchaseService.instance.buyCollection(product);
    } catch (e) {
      state = state.copyWith(
        errorMessage: () => 'Nákup se nezdařil.',
      );
    }
  }

  Future<void> restorePurchases() async {
    state = state.copyWith(isRestoring: true);
    try {
      await PurchaseService.instance.restorePurchases();
    } catch (_) {
      // Errors will come through the purchase stream
    }
    // isRestoring will be cleared when stream events finish
    // Use a short delay to clear if no events arrive
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      state = state.copyWith(isRestoring: false);
    }
  }

  void _handlePurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final details in purchaseDetailsList) {
      switch (details.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _onPurchaseSuccess(details);
          break;
        case PurchaseStatus.error:
          state = state.copyWith(
            errorMessage: () =>
                details.error?.message ?? 'Chyba při nákupu.',
          );
          _completePurchase(details);
          break;
        case PurchaseStatus.pending:
          // Waiting for platform — no action needed
          break;
        case PurchaseStatus.canceled:
          _completePurchase(details);
          break;
      }
    }

    // Clear restoring flag after processing
    if (state.isRestoring) {
      state = state.copyWith(isRestoring: false);
    }
  }

  Future<void> _onPurchaseSuccess(PurchaseDetails details) async {
    final collectionId = productIdToCollectionId[details.productID];
    if (collectionId != null) {
      await _unlockCollection(collectionId);
    }
    await _completePurchase(details);
  }

  Future<void> _unlockCollection(String collectionId) async {
    if (state.isUnlocked(collectionId)) return;

    // Load poems from YAML and save to Hive
    final poems = await loadCollectionPoems(collectionId);
    if (poems.isNotEmpty) {
      await _savePurchasedPoems(collectionId, poems);
    }

    // Update state
    final updatedIds = {...state.unlockedCollectionIds, collectionId};
    state = state.copyWith(
      unlockedCollectionIds: updatedIds,
      errorMessage: () => null,
    );

    // Persist unlocked IDs
    await _saveUnlockedIds(updatedIds);

    // Refresh poem list so new poems appear
    _ref.read(poemListProvider.notifier).refresh();
  }

  Future<void> _completePurchase(PurchaseDetails details) async {
    if (details.pendingCompletePurchase) {
      await PurchaseService.instance.completePurchase(details);
    }
  }

  // -- Hive persistence --

  static const _boxName = 'purchases';
  static const _unlockedKey = 'unlocked_ids';
  static const _poemsBoxName = 'purchased_poems';

  Future<Set<String>> _loadUnlockedIds() async {
    final box = await Hive.openBox(_boxName);
    final raw = box.get(_unlockedKey);
    if (raw == null) return {};
    final list = (jsonDecode(raw as String) as List).cast<String>();
    return list.toSet();
  }

  Future<void> _saveUnlockedIds(Set<String> ids) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_unlockedKey, jsonEncode(ids.toList()));
  }

  Future<void> _savePurchasedPoems(
      String collectionId, List<dynamic> poems) async {
    final box = await Hive.openBox(_poemsBoxName);
    // Store per collection for clean separation
    await box.put(
      collectionId,
      jsonEncode(poems.map((p) => p.toJson()).toList()),
    );
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseNotifier, PurchaseState>((ref) {
  return PurchaseNotifier(ref);
});
