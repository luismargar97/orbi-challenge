import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/models/pokemon_list/pokemon.list.model.dart';

class SortingPokemon {
  static SortBy currentSortMethod = SortBy.none;

  static List<Pokemon> sortList(List<Pokemon> listToSort) {
    switch (currentSortMethod) {
      case SortBy.nameAsc:
        listToSort.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortBy.nameDesc:
        listToSort.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortBy.idAsc:
        listToSort.sort((a, b) => a.id.compareTo(b.id));
        break;
      case SortBy.idDesc:
        listToSort.sort((a, b) => b.id.compareTo(a.id));
        break;
      case SortBy.weightAsc:
        listToSort.sort((a, b) => a.weight! - b.weight!);
        break;
      case SortBy.weightDesc:
        listToSort.sort((a, b) => b.weight! - a.weight!);
        break;
      case SortBy.heightAsc:
        listToSort.sort((a, b) => a.height! - b.height!);
        break;
      case SortBy.heightDesc:
        listToSort.sort((a, b) => b.height! - a.height!);
        break;

      default:
        break;
    }

    return listToSort;
  }
}
