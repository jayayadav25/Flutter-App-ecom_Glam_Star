//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../data/repositories/editorial_repository.dart';
// import '../domain/usecases/build_home_feed.dart';
// import '../widgets/editorial_mapper.dart';
// import '../widgets/home_feed_item.dart';
// import 'home_provider.dart';
//
// /// -------------------------------
// /// HOME FEED PROVIDER
// /// -------------------------------
//
// final homeFeedProvider =
// FutureProvider.family<List<HomeFeedItem>, String>((ref, userId) async {
//   /// 🔹 Static sections
//   final homeTab = ref.watch(homeTabProvider);
//   final editorialType = mapHomeTabToEditorial(homeTab);
//   final editorialSections =
//   EditorialRepository.getSections(editorialType);
//
//   /// 🔹 Build unified feed
//   return BuildHomeFeed()(
//     editorial: editorialSections,
//     recommended: recommended,
//     trending: trending,
//   );
// });
