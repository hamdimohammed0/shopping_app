import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCubit extends Cubit<Set<int>> {
  FavoriteCubit() : super({}) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final sharf = await SharedPreferences.getInstance();

    final favorites = sharf.getStringList('favorites') ?? [];

    final favoriteId = favorites.map((id) => int.parse(id)).toSet();

    emit(favoriteId);
  }

  Future<void> toggleFavorite(int productId) async {
    final favorites = Set<int>.from(state);

    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }

    emit(favorites);

    final sharf = await SharedPreferences.getInstance();
    await sharf.setStringList(
      'favorites',
      favorites.map((id) => id.toString()).toList(),
    );
  }

  bool isFavorite(int productId) {
    return state.contains(productId);
  }
}
