import '../providers/home_provider.dart';
import '../domain/entities/sub_category_type.dart';


SubCategoryType? mapTabToSubCategory(HomeTab tab) {
  switch (tab) {
    case HomeTab.women:
      return SubCategoryType.women;
    case HomeTab.men:
      return SubCategoryType.men;
    case HomeTab.kids:
      return SubCategoryType.kids;
    case HomeTab.home:
    default:
      return null;
  }
}
