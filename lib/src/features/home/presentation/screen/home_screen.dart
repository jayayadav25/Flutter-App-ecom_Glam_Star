import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../products/presentation/light_product_card.dart';
import '../../../products/providers/light_product_provider.dart';
import '../../providers/home_provider.dart';
import '../../data/repositories/editorial_repository.dart';
import '../../widgets/editorial_mapper.dart';
import '../../widgets/banner_mapper.dart';
import '../../widgets/reusable_widget.dart';
import '../../widgets/sub_category_mappper.dart';
import '../../widgets/home_tabbar_cards.dart';
import 'banner_section.dart';
import '../../widgets/editorial_image_card.dart';
import 'sub_category_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(productsLightProvider.notifier).fetchNext();
    }
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<HomeTab>(homeTabProvider, (_, __) {
      ref.read(productsLightProvider.notifier).resetAndFetch();
    });
    final selectedTab = ref.watch(homeTabProvider);
    final paginatedState = ref.watch(productsLightProvider);
    final bannerType = mapHomeTabToBanner(selectedTab);
    final subCategoryType = mapTabToSubCategory(selectedTab);
    final editorialType = mapHomeTabToEditorial(selectedTab);
    final editorialSections =
    EditorialRepository.getSections(editorialType);


    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [

            // Tab bar
            const SliverToBoxAdapter(
              child: HomeTabBar(),
            ),

            // Banner
            SliverToBoxAdapter(
              child: BannerCarousel(type: bannerType),
            ),

            // Sub category
            if (subCategoryType != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SubCategoryScreen(type: subCategoryType),
                ),
              ),


            // Editorial sections
            for (final section in editorialSections) ...[
              // Header
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: section.title,
                  subtitle: section.subtitle,
                ),
              ),

              // Horizontal list
              if (section.title == "Fresh Drops" ||
                  section.title == "Style Buzz" ||
                  section.title == "House of Trends" ||
                  section.title == "The Power Closet" ||
                  section.title == "Little Legends" ||
                  section.title == "Little Fashion Hub" ||
                  section.title == "Trend Queen" ||
                  section.title == "Where Fashion Lives")
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 220,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: section.items.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 12),
                      itemBuilder: (_, i) => SizedBox(
                        width: 150,
                        child: EditorialImageCard(
                          data: section.items[i],
                        ),
                      ),
                    ),
                  ),
                ),

              // Staggered grid
                if (section.title == "Style Spotlight" ||
                    section.title == "Mini Trendsetter")
                  QuiltedGridSliver(items: section.items),


              // Carousel
              if (section.title == "Hot Right Now" ||
                  section.title == "Boost Your Style Sense" ||
                  section.title == "Wear your story")
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 230,
                    child: PageView.builder(
                      itemCount: section.items.length,
                      itemBuilder: (_, i) => Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        child: EditorialImageCard(
                          data: section.items[i],
                          borderRadius: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 16, 18, 8),
                child: Text(
                  "Explore Products",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Product grid
            if (paginatedState.error != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      paginatedState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              )
            else if (paginatedState.items.isEmpty && paginatedState.isLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            else if (paginatedState.items.isEmpty)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text("No products found")),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(5),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        /// 🔄 Loader at bottom
                        if (index >= paginatedState.items.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        }

                        // Product card
                        return LightProductCard(
                          product: paginatedState.items[index],
                        );
                      },
                      childCount: paginatedState.hasMore
                          ? paginatedState.items.length + 1
                          : paginatedState.items.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.62,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

}

