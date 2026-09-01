import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/grid_background.dart';
import '../widgets/circular_stat_gauge.dart';
import '../widgets/profile_stat_box.dart';

class ProfileScreen extends StatelessWidget {
  final String registryId;
  final String callsign;
  final String roleLabel;
  final int level;
  final String? avatarUrl;
  final double winRatePercent;
  final int victories;
  final int defeats;
  final int stalemates;
  final VoidCallback? onViewAllMedals;

  const ProfileScreen({
    super.key,
    required this.registryId,
    required this.callsign,
    required this.roleLabel,
    required this.level,
    this.avatarUrl,
    required this.winRatePercent,
    required this.victories,
    required this.defeats,
    required this.stalemates,
    this.onViewAllMedals,
  });

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const .fromLTRB(20, 12, 20, 32),
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    Center(child: _buildAvatar()),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        callsign.toUpperCase(),
                        style: AppTypography.h1.copyWith(
                          color: AppColors.primaryText,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        roleLabel.toUpperCase(),
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.coreCyan,
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                Center(child: CircularStatGauge(percentage: winRatePercent)),

                // const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ProfileStatBox(
                        value: '$victories',
                        label: 'Victories',
                        valueColor: AppColors.coreCyan,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ProfileStatBox(
                        value: '$defeats',
                        label: 'Defeats',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ProfileStatBox(
                        value: '$stalemates',
                        label: 'Stalemates',
                      ),
                    ),
                  ],
                ),
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
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primaryText,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'PILOT DOSSIER',
                style: AppTypography.h4.copyWith(color: AppColors.coreCyan),
              ),
              const SizedBox(height: 2),
              Text(
                'REGISTRY // $registryId',
                style: AppTypography.caption.copyWith(
                  color: AppColors.lowContrastText,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share_outlined, color: AppColors.primaryText),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.coreCyan, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.coreCyan.withOpacity(0.4),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipOval(
            child: avatarUrl != null
                ? Image.network(avatarUrl!, fit: BoxFit.cover)
                : Container(
                    color: AppColors.inputBackground,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.mutedCyan,
                      size: 44,
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: -4,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.deepSpaceDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.coreCyan, width: 1),
              ),
              child: Text(
                'LVL $level',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.coreCyan,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
