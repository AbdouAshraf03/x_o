part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}

final class GameInProgress extends GameState {
  final int remaining;

  const GameInProgress({required this.remaining});

  GameInProgress copyWith({int? remaining}) {
    return GameInProgress(remaining: remaining ?? this.remaining);
  }

  @override
  List<Object> get props => [remaining];
}

final class GameOver extends GameState {
  final String? winner;

  const GameOver({this.winner});

  @override
  List<Object> get props => [winner ?? ''];
}
