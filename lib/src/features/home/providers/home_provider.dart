import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../../products/providers/light_product_provider.dart';
import '../data/home_repository.dart';
import '../data/home_repository_impl.dart';
import '../datasources/home_firestore_source.dart';

enum HomeTab {
  home,
  women,
  men,
  kids,
}

final homeTabProvider = StateProvider<HomeTab>((ref) => HomeTab.home,);

final homeFirestoreSourceProvider = Provider<HomeFirestoreSource>((ref) {
    return HomeFirestoreSource();
  },
);

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
    final source = ref.read(homeFirestoreSourceProvider);
    return HomeRepositoryImpl(source);
  },
);

final homeTabListenerProvider = Provider<void>((ref) {
  ref.listen<HomeTab>(
    homeTabProvider, (_, __) {
      ref.read(productsLightProvider.notifier).resetAndFetch();
    },
  );
});

final homeProductsProvider = FutureProvider<List<ProductModel>>((ref) async {
    final repo = ref.read(homeRepositoryProvider);
    final tab = ref.watch(homeTabProvider);
    switch (tab) {
      case HomeTab.women:
        return repo.fetchByCategory('women');

      case HomeTab.men:
        return repo.fetchByCategory('men');

      case HomeTab.kids:
        return repo.fetchByCategory('kids');

      case HomeTab.home:
      default:
        return repo.fetchLatestProducts(
          limit: 20,
        );
    }
  },
);
