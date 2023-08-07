
import 'package:tourist_guide/models/favorite.dart';

abstract class IFavoritesDataSource{

  Future<bool> addToFavorites(Favorite favorite);
  getFavoriteAttractions();
  getFavoriteHotels();
  getFavoriteTourGuides();
  removeFromFavorites(String itemId);


}