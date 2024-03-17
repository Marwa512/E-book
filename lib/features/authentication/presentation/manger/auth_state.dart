abstract class AuthEbookState {}

class AuthInitialState extends AuthEbookState {}

class LoginLoadingState extends AuthEbookState {}

class LoginSucessState extends AuthEbookState {}

class LoginErrorState extends AuthEbookState {
  final String error;

  LoginErrorState(this.error);
}

class LoginchangePasswordVisibilityState extends AuthEbookState {}

class LogoutSucessState extends AuthEbookState {}

class LogoutErrorState extends AuthEbookState {}
class RegisterLoadingState extends AuthEbookState {}

class RegisterSucessState extends AuthEbookState {}

class RegisterErrorState extends AuthEbookState {
  final String error;

  RegisterErrorState(this.error);
}
class CreateUserLoadingState extends AuthEbookState {}

class CreateUserSucessState extends AuthEbookState {}

class CreateUserErrorState extends AuthEbookState {
  final String error;

  CreateUserErrorState(this.error);
}
abstract class HomeEbookState {}

class HomeInitialState extends HomeEbookState {}

class GetUserLoadingState extends AuthEbookState {}
class GetUserSuccessState extends AuthEbookState {}
class GetUserErrorState extends AuthEbookState {
   final String error;

  GetUserErrorState(this.error);
}
class GetAllUserLoadingState extends AuthEbookState {}
class GetAllUserSuccessState extends AuthEbookState {}
class GetAllUserErrorState extends AuthEbookState {
   final String error;

  GetAllUserErrorState(this.error);
}

class AdminAcceptVerLoadingState extends AuthEbookState {}
class AdminAcceptVerSuccessState extends AuthEbookState {}
class AdminAcceptVerErrorState extends AuthEbookState {
   final String error;

  AdminAcceptVerErrorState(this.error);
}

class SendVerLoadingState extends AuthEbookState {}
class SendVerSuccessState extends AuthEbookState {}
class SendtVerErrorState extends AuthEbookState {
   final String error;

  SendtVerErrorState(this.error);
}
