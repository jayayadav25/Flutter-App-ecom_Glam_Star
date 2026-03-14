import '../domain/entities/editorial_type.dart';
import '../providers/home_provider.dart';

EditorialType mapHomeTabToEditorial(HomeTab tab) {
  switch (tab) {
    case HomeTab.women:
      return EditorialType.women;

    case HomeTab.men:
      return EditorialType.men;

    case HomeTab.kids:
      return EditorialType.kids;

    case HomeTab.home:
    default:
      return EditorialType.home;
  }
}
