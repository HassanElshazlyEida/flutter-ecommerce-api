abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
class AuthLoadingState extends AuthStates {}
class AuthErrorState extends AuthStates {
  String message;
  
  AuthErrorState(this.message);
}
class AuthAuthenticatedState extends AuthStates {}
class AuthUnauthenticatedState extends AuthStates {}
