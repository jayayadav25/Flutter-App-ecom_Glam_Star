import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/styles/colors.dart';
import '../../../products/providers/light_product_provider.dart';
import '../../providers/home_provider.dart';
import '../../widgets/banner_mapper.dart';
import '../../widgets/editorial_mapper.dart';
import '../../widgets/editorial_section_silver.dart';
import '../../widgets/home_banner_section.dart';
import '../../widgets/home_product_grid.dart';
import '../../widgets/home_tabbar_cards.dart';
import '../../widgets/sub_category_mappper.dart';
import '../../widgets/subcategory_grid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends ConsumerState<HomeScreen> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(_onScroll);
  }

  void _onScroll() {

    final notifier =
    ref.read(productsLightProvider.notifier);

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {

      notifier.fetchNext();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HomeTab>(
      homeTabProvider,
          (_, __) {
        ref.read(productsLightProvider.notifier).resetAndFetch();
      },
    );

    final selectedTab = ref.watch(homeTabProvider);
    final bannerType = mapHomeTabToBanner(selectedTab);
    final editorialType = mapHomeTabToEditorial(selectedTab);
    final subCategoryType = mapTabToSubCategory(selectedTab);
    return Scaffold(

      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: HomeTabBar(),
            ),
            SliverToBoxAdapter(
              child: HomeBannerSection(
                type: bannerType,
              ),
            ),

            if (subCategoryType != null)
              SliverToBoxAdapter(
                child: SubCategorySection(
                  type: subCategoryType,
                ),
              ),

            SliverToBoxAdapter(
              child: HomeEditorialSection(
                type: editorialType,
              ),
            ),

            const HomeProductGrid(),
          ],
        ),
      ),
    );
  }
}