import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService {
  PurchaseService._();
  static final PurchaseService instance = PurchaseService._();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  void Function(List<PurchaseDetails>)? onPurchaseUpdate;

  Future<void> initialize({
    required void Function(List<PurchaseDetails>) onPurchaseUpdate,
  }) async {
    this.onPurchaseUpdate = onPurchaseUpdate;
    _subscription = _iap.purchaseStream.listen(
      onPurchaseUpdate,
      onError: (error) {
        // Purchase stream errors are handled via PurchaseStatus.error
      },
    );
  }

  Future<bool> isAvailable() => _iap.isAvailable();

  Future<ProductDetailsResponse> queryProducts(Set<String> productIds) =>
      _iap.queryProductDetails(productIds);

  Future<bool> buyCollection(ProductDetails product) =>
      _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: product));

  Future<void> restorePurchases() => _iap.restorePurchases();

  Future<void> completePurchase(PurchaseDetails details) =>
      _iap.completePurchase(details);

  void dispose() {
    _subscription?.cancel();
  }
}
