import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthEvent { login, logout }

enum AuthStatus { initial, authenticating, authenticated, unauthenticated }

// only one class to represent state
// use status enum to represent different states
// bloc documentation suggests this approach or use child classes
class AuthState {
  final AuthStatus status;
  final String? user;
  AuthState({
    required this.status,
    required this.user,
  });

  factory AuthState.initial() =>
      AuthState(status: AuthStatus.initial, user: null);

  factory AuthState.authenticating() =>
      AuthState(status: AuthStatus.authenticating, user: null);

  factory AuthState.authenticated(String user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  factory AuthState.unauthenticated() =>
      AuthState(status: AuthStatus.unauthenticated, user: null);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.authenticated("william")) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        // todo: bad solution, login should probably check credentials
        case AuthEvent.login:
          emit(AuthState.authenticating());
          // delay could be firebase/http/whatever authentication call
          await Future.delayed(const Duration(milliseconds: 500));
          emit(AuthState.authenticated("william"));
          break;
        case AuthEvent.logout:
          emit(AuthState.unauthenticated());
          break;
      }
    });
  }
}
