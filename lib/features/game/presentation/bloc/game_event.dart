part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

final class TimerTicked extends GameEvent {
  final int remaining;

  const TimerTicked({required this.remaining});

  @override
  List<Object> get props => [remaining];
}

final class GameStarted extends GameEvent {
  final DateTime turnStartedAt;
  final int durationSeconds;

  const GameStarted({
    required this.turnStartedAt,
    required this.durationSeconds,
  });

  @override
  List<Object> get props => [turnStartedAt, durationSeconds];
}
