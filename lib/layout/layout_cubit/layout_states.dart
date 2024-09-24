abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}
class FetchingDataState extends LayoutStates {}
class DataLoadedState extends LayoutStates {}
class ChangeBottomNavIndexState extends LayoutStates {}
class ErrorFetchingDataState extends LayoutStates {
  final String message;
  ErrorFetchingDataState(this.message);
}