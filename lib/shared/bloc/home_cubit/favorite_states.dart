abstract class FavoriteStates {}

class IdleFavoriteState extends FavoriteStates {}

class ChnageFavoriteState extends FavoriteStates {}

class SuccessFavoriteState extends FavoriteStates {
  final String message;
  final bool status;
  SuccessFavoriteState({this.message, this.status});
}
class LoadingFavoriteProductsState extends FavoriteStates{}
class SuccessFavoriteProductsState extends FavoriteStates{}


class ErrorFavoriteState extends FavoriteStates {
  final String error;
  ErrorFavoriteState(this.error);
}
