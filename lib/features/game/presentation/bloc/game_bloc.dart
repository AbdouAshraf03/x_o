import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? _timer;

  GameBloc() : super(GameInitial()) {
    on<TimerTicked>(_timerTicked);
    on<GameStarted>(_gameStarted);
  }

  void _gameStarted(GameStarted event, Emitter<GameState> emit) {
    _timer?.cancel();

    emit(GameInProgress(remaining: event.durationSeconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(TimerTicked(remaining: event.durationSeconds - 1));
    });
  }

  void _timerTicked(TimerTicked event, Emitter<GameState> emit) {
    if (state is! GameInProgress) return;

    final currState = state as GameInProgress;
    final newRemaining = currState.remaining - 1;

    debugPrint('Timer ticked: $newRemaining seconds remaining');

    if (newRemaining <= 0) {
      _timer?.cancel();

      emit(const GameOver(winner: null));
    } else {
      emit(currState.copyWith(remaining: newRemaining));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
