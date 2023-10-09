import 'package:bloc/bloc.dart';
import 'package:clique_king_model/clique_king_model.dart';
import 'package:clique_king_model/src/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
sealed class UserEvent {}

final class UserStarted extends UserEvent {}

final class UserRegister extends UserEvent {
  final String email;
  final String password;
  final String name;

  UserRegister(
      {required this.email, required this.password, required this.name});
}

final class UserLogin extends UserEvent {
  final String email;
  final String password;

  UserLogin({required this.email, required this.password});
}

final class UserLogout extends UserEvent {}

final class UserDelete extends UserEvent {}

// ---

@immutable
sealed class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoginInProgress extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoginSuccess extends UserState {
  final User user;

  UserLoginSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}

final class UserLoginFailure extends UserState {
  @override
  List<Object?> get props => [];
}

// TODO: Registration states?

final class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepo; // passed in so it can be easily mocked
  final AuthenticationRepository _authRepo; // passed in so it can be easily mocked

  UserBloc(
      {required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _userRepo = userRepository,
        _authRepo = authenticationRepository,
        super(UserInitial()) {
    on<UserEvent>(
      (event, emit) async {
        switch (event) {
          case UserStarted():
            emit(UserLoginInProgress());
          // TODO: Attempt to login using potentially stored local token.
          case UserRegister():
          // TODO: Handle this case.
          case UserLogin():
          // TODO: Handle this case.
          case UserLogout():
          // TODO: Handle this case.
          case UserDelete():
          // TODO: Handle this case.
        }
      },
    );
  }
}
