import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../../products/providers/light_product_provider.dart';
import '../data/repositories/home_repository_impl.dart';
import '../datasources/home_firestore_source.dart';
import '../data/repositories/home_repository.dart';

enum HomeTab { home, women, men, kids }
// final homeRepositoryProvider = Provider((ref) => HomeRepository());

final homeFirestoreSourceProvider =
Provider<HomeFirestoreSource>((ref) {
  return HomeFirestoreSource();
});

final homeRepositoryProvider =
Provider<HomeRepository>((ref) {
  final source = ref.read(homeFirestoreSourceProvider);
  return HomeRepositoryImpl(source);
});

final homeTabListenerProvider = Provider<void>((ref) {
  ref.listen<HomeTab>(homeTabProvider, (_, __) {
    ref.read(productsLightProvider.notifier).resetAndFetch();
  });
});

// Selected Tab
final homeTabProvider =
StateProvider<HomeTab>((ref) => HomeTab.home);

// Products based on selected tab
final homeProductsProvider =
FutureProvider<List<ProductModel>>((ref) async {
  final repo = ref.read(homeRepositoryProvider);
  final tab = ref.watch(homeTabProvider); // 🔥 THIS MAKES IT REACTIVE

  switch (tab) {
    case HomeTab.women:
      return repo.fetchByCategory('women');
    case HomeTab.men:
      return repo.fetchByCategory('men');
    case HomeTab.kids:
      return repo.fetchByCategory('kids');
    case HomeTab.home:
    default:
      return repo.fetchLatestProducts(limit: 20);
  }
});

// Latest Products (Nykaa landing grid)
final latestProductsProvider =
FutureProvider<List<ProductModel>>((ref) async {
  final repo = ref.read(homeRepositoryProvider);
  return repo.fetchLatestProducts(limit: 20);
});

// Category selection
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Category-wise products
final categoryProductsProvider =
FutureProvider<List<ProductModel>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);
  if (category == null) return [];

  return ref.read(homeRepositoryProvider).fetchByCategory(category);
});
