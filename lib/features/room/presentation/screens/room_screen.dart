import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/grid_background.dart';
import '../../../../core/widgets/custom_gradient_button.dart';
import '../widget/room_info_row.dart';
import '../widget/player_slot_card.dart';

class RoomScreen extends StatelessWidget {
  final String roomCode;
  final String roomName;
  final String hostName;
  final String? hostAvatarUrl;
  final String? guestName;
  final String? guestAvatarUrl;
  final VoidCallback? onStart;
  // final VoidCallback? onAbort;
  final VoidCallback? onSettings;
  final VoidCallback? onKickGuest;

  const RoomScreen({
    super.key,
    required this.roomCode,
    required this.roomName,
    required this.hostName,
    this.hostAvatarUrl,
    this.guestName,
    this.guestAvatarUrl,
    this.onStart,
    // this.onAbort,
    this.onSettings,
    this.onKickGuest,
  });

  bool get _isFull => guestName != null;

  void _onAbort(BuildContext context) {
    //TODO: remove the room from firebase
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                _buildHeader(context),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: PlayerSlotCard.filled(
                        name: hostName,
                        role: 'Commander (Host)',
                        // symbol: 'X',
                        avatarUrl: hostAvatarUrl,
                        isOwner: true,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: guestName != null
                          ? PlayerSlotCard.filled(
                              name: guestName!,
                              role: 'Challenger',
                              // symbol: 'O',
                              avatarUrl: guestAvatarUrl,
                              onKick: onKickGuest,
                            )
                          : const PlayerSlotCard.empty(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
                const RoomInfoRow(
                  label: 'Encryption',
                  value: 'Active // 256-Bit',
                ),
                const Divider(height: 1),
                const RoomInfoRow(label: 'Game Mode', value: 'Standard 3x3'),
                const Spacer(),
                CustomGradientButton(
                  label: 'Initiate Combat',
                  onPressed: _isFull ? onStart : null,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _onAbort(context),
                    style: OutlinedButton.styleFrom(
                      padding: const .symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.glassBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(28),
                      ),
                    ),
                    child: Text(
                      'ABORT MISSION',
                      style: AppTypography.button.copyWith(
                        color: AppColors.lowContrastText,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // IconButton(
        //   onPressed: () => Navigator.of(context).maybePop(),
        //   icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
        // ),
        Expanded(
          child: Column(
            children: [
              Text(
                'DOCKING BAY $roomCode',
                style: AppTypography.h4.copyWith(color: AppColors.coreCyan),
              ),
              const SizedBox(height: 2),
              Text(
                roomName.toUpperCase(),
                style: AppTypography.caption.copyWith(
                  color: AppColors.lowContrastText,
                ),
              ),
            ],
          ),
        ),
        // IconButton(
        //   onPressed: onSettings,
        //   icon: const Icon(
        //     Icons.settings_outlined,
        //     color: AppColors.primaryText,
        //   ),
        // ),
      ],
    );
  }
}
