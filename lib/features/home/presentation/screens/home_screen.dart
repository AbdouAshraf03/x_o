import 'package:flutter/material.dart';
import 'package:x_o/core/routes/routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/grid_background.dart';
import 'widgets/stat_card.dart';
import 'widgets/room_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleCreateNewRoom(BuildContext context) {
    //TODO: _handleCreateNewRoom
    Navigator.of(context).pushNamed(Routes.waitingRoom);
  }

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // floatingActionButton: FloatingActionButton.extended(
          //   // label:
          //   // child:,
          //   onPressed: () {},
          // ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: [
              _Header(),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(
                    child: StatCard(label: 'Active Rooms', value: '24'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(label: 'Online Pilots', value: '142'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(
                    Icons.radar,
                    size: 14,
                    color: AppColors.lowContrastText,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SCANNING FOR SIGNALS...',
                    style: AppTypography.overline.copyWith(
                      color: AppColors.lowContrastText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RoomCard(
                roomName: 'Orion_Station',
                hostName: 'Cmdr. Kaelen',
                icon: Icons.rocket_launch_outlined,
                isOpen: true,
                occupied: 1,
                capacity: 2,
                onTap: () {
                  // TODO: navigate to RoomScreen.
                },
              ),
              RoomCard(
                roomName: 'Nebula_Void',
                hostName: 'Star_Dust',
                icon: Icons.travel_explore,
                isOpen: true,
                occupied: 1,
                capacity: 2,
                onTap: () {
                  // TODO: navigate to RoomScreen.
                },
              ),
              const RoomCard(
                roomName: 'Hyperion_Core',
                hostName: 'Admin_Zero',
                icon: Icons.shield_outlined,
                isOpen: false,
                occupied: 2,
                capacity: 2,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: _CombatSimulatorCard(
                      onTap: () {
                        // TODO: navigate to AiDifficultySelectScreen / AiGameScreen.
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.glassPanelSurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => _handleCreateNewRoom(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: Expanded(
                            child: Text(
                              "NEW ROOM",
                              textAlign: TextAlign.center,
                              style: AppTypography.labelSmall.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.coreCyan,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Transform.rotate(
          angle: 0.785398,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.actionGradient,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Transform.rotate(
              angle: -0.785398,
              child: Center(
                child: Text(
                  'XO',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DOCKING BAYS',
                style: AppTypography.h3.copyWith(color: AppColors.primaryText),
              ),
              const SizedBox(height: 2),
              Text(
                'SECTOR: LOBBY-1',
                style: AppTypography.overline.copyWith(
                  color: AppColors.mutedCyan,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'PILOT',
              style: AppTypography.overline.copyWith(
                color: AppColors.lowContrastText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'VIPER_99',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.coreCyan,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.coreCyan, width: 1.5),
          ),
          child: ClipOval(
            child: Container(
              color: AppColors.inputBackground,
              child: const Icon(
                Icons.person,
                color: AppColors.mutedCyan,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CombatSimulatorCard extends StatelessWidget {
  final VoidCallback onTap;

  const _CombatSimulatorCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassPanelSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.memory,
                    color: AppColors.coreCyan,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COMBAT SIMULATOR',
                        style: AppTypography.h6.copyWith(
                          color: AppColors.coreCyan,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Practice against AI Unit',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.mutedCyan,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.lowContrastText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
