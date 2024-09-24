abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}
class LoadingUserDataState extends LayoutStates {}
class SuccessUserDataState extends LayoutStates {}
class ErrorUserDataState extends LayoutStates {
  final String message;
  ErrorUserDataState(this.message);
}