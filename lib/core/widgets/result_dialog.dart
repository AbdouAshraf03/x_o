import 'package:flutter/material.dart';

/// Shared end-of-game dialog for both online and AI matches.
/// Shows the outcome and offers rematch/exit actions.
class ResultDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRematch;
  final VoidCallback onExit;

  const ResultDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onExit,
    this.onRematch,
  });

  /// Convenience constructor for a win.
  factory ResultDialog.win({
    required String winnerLabel,
    VoidCallback? onRematch,
    required VoidCallback onExit,
  }) {
    return ResultDialog(
      title: '$winnerLabel Wins!',
      message: 'The board is settled — nicely played.',
      onRematch: onRematch,
      onExit: onExit,
    );
  }

  /// Convenience constructor for a draw.
  factory ResultDialog.draw({
    VoidCallback? onRematch,
    required VoidCallback onExit,
  }) {
    return ResultDialog(
      title: "It's a Draw",
      message: 'No winner this time.',
      onRematch: onRematch,
      onExit: onExit,
    );
  }

  /// Convenience constructor for a forfeit/timeout.
  factory ResultDialog.forfeit({
    required String forfeitedByLabel,
    VoidCallback? onRematch,
    required VoidCallback onExit,
  }) {
    return ResultDialog(
      title: 'Turn Forfeited',
      message: '$forfeitedByLabel ran out of time.',
      onRematch: onRematch,
      onExit: onExit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onExit,
          child: const Text('Exit'),
        ),
        if (onRematch != null)
          FilledButton(
            onPressed: onRematch,
            child: const Text('Rematch'),
          ),
      ],
    );
  }
}
