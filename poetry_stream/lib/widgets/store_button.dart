import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/visual.dart';
import '../data/repositories/collection_repository.dart';
import '../providers/purchase_provider.dart';

class StoreButton extends StatelessWidget {
  const StoreButton({super.key});

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _StoreSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.shopping_cart_outlined,
          size: 18,
          color: Colors.white.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

class _StoreSheet extends ConsumerWidget {
  const _StoreSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseState = ref.watch(purchaseProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      margin: EdgeInsets.only(top: topPadding + 40),
      decoration: BoxDecoration(
        color: VisualConstants.backgroundColor,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sbírky básní',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 22,
                    color: Colors.white.withValues(alpha: 0.6),
                    letterSpacing: 1,
                  ),
                ),
                GestureDetector(
                  onTap: purchaseState.isRestoring
                      ? null
                      : () => ref
                            .read(purchaseProvider.notifier)
                            .restorePurchases(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: purchaseState.isRestoring
                        ? SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          )
                        : Text(
                            'OBNOVIT',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 12,
                              letterSpacing: 1.5,
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),

          // Error message
          if (purchaseState.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Text(
                purchaseState.errorMessage!,
                style: GoogleFonts.spectral(
                  fontSize: 13,
                  color: const Color(0xFFE8A87C).withValues(alpha: 0.7),
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Collection list
          if (purchaseState.isLoading)
            Padding(
              padding: const EdgeInsets.all(40),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                shrinkWrap: true,
                itemCount: availableCollections.length,
                separatorBuilder: (_, _) => Divider(
                  color: Colors.white.withValues(alpha: 0.05),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final collection = availableCollections[index];
                  final isUnlocked =
                      purchaseState.isUnlocked(collection.id);
                  final product =
                      purchaseState.products[collection.productId];

                  return _CollectionTile(
                    collection: collection,
                    isUnlocked: isUnlocked,
                    price: product?.price,
                    isAvailable: purchaseState.isAvailable && product != null,
                    onBuy: () {
                      if (product != null) {
                        ref
                            .read(purchaseProvider.notifier)
                            .purchaseCollection(product);
                      }
                    },
                  );
                },
              ),
            ),

          // Store unavailable notice
          if (!purchaseState.isLoading && !purchaseState.isAvailable)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Text(
                'Obchod není dostupný. Zkontrolujte připojení.',
                style: GoogleFonts.spectral(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.25),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  final dynamic collection;
  final bool isUnlocked;
  final String? price;
  final bool isAvailable;
  final VoidCallback onBuy;

  const _CollectionTile({
    required this.collection,
    required this.isUnlocked,
    required this.price,
    required this.isAvailable,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Collection info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collection.title,
                  style: GoogleFonts.spectral(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  collection.description,
                  style: GoogleFonts.spectral(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${collection.poemCount} básní',
                  style: GoogleFonts.spectral(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Buy button or unlocked badge
          if (isUnlocked)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFA8C4D4).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'ODEMČENO',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 12,
                  letterSpacing: 1.5,
                  color: const Color(0xFFA8C4D4).withValues(alpha: 0.7),
                ),
              ),
            )
          else
            GestureDetector(
              onTap: isAvailable ? onBuy : null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  price != null ? 'KOUPIT $price' : 'KOUPIT',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 12,
                    letterSpacing: 1.5,
                    color: isAvailable
                        ? const Color(0xFFA8C4D4)
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
