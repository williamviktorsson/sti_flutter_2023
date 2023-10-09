import 'package:bloc/bloc.dart';
import 'package:clique_king_model/clique_king_model.dart';
import 'package:clique_king_model/src/models/clique.dart';
import 'package:clique_king_model/src/repositories/clique_repository.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CliquesEvent {}

// TODO: add CliquesLoadEvent or Reload
// TODO: add newCliqueEvent

@immutable
sealed class CliquesState {}

final class CliquesInitial extends CliquesState {}

final class CliquesLoadingInProgress extends CliquesState {}

final class CliquesLoadingSuccess extends CliquesState {
  final List<Clique> cliques;

  CliquesLoadingSuccess({required this.cliques});
}

final class CliquesLoadingFailure extends CliquesState {}

final class CliquesBloc extends Bloc<CliquesEvent, CliquesState> {
  final CliqueRepository _cliqueRepo; // passed in so it can be easily mocked

  CliquesBloc({required CliqueRepository cliqueRepository})
      : _cliqueRepo = cliqueRepository,
        super(CliquesInitial()) {
    on<CliquesEvent>(
      (event, emit) async {
        switch (event) {}
      },
    );
  }
}
