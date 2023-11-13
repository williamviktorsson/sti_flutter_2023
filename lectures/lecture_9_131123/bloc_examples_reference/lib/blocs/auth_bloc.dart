import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthEvent { login, logout }

enum AuthStatus { initial, authenticating, authenticated, unauthenticated }

class AuthState {
  String? user;
  AuthStatus status;
  AuthState({
    required this.user,
    required this.status,
  });

  AuthState.initial() : this(user: null, status: AuthStatus.initial);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEvent.login:
          emit(AuthState(user: null, status: AuthStatus.authenticating));
          await Future.delayed(const Duration(seconds: 1));
          emit(AuthState(user: "william", status: AuthStatus.authenticated));
        case AuthEvent.logout:
          emit(AuthState(user: null, status: AuthStatus.unauthenticated));
      }
    });
  }
}
