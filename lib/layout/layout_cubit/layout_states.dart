abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}
class ChangeBottomNavIndexState extends LayoutStates {}

class LoadingUserDataState extends LayoutStates {}
class SuccessUserDataState extends LayoutStates {}
class ErrorUserDataState extends LayoutStates {
  final String message;
  ErrorUserDataState(this.message);
}

class LoadingCategoriesState extends LayoutStates {}
class SuccessCategoriesState extends LayoutStates {}
class ErrorCategoriesState extends LayoutStates {
  final String message;
  ErrorCategoriesState(this.message);
}

class LoadingBannersState extends LayoutStates {}
class SuccessBannersState extends LayoutStates {}
class ErrorBannersState extends LayoutStates {
  final String message;
  ErrorBannersState(this.message);
}

class LoadingProductsState extends LayoutStates {}
class SuccessProductsState extends LayoutStates {}
class FilterProductsState extends LayoutStates {}
class ErrorProductsState extends LayoutStates {
  final String message;
  ErrorProductsState(this.message);
}

class LoadingWishlistState extends LayoutStates {}
class SuccessWishlistState extends LayoutStates {}
class FilterWishlistState extends LayoutStates {}
class ErrorWishlistState extends LayoutStates {
  final String message;
  ErrorWishlistState(this.message);
}
