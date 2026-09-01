import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';
import 'custom_scan_paint.dart';

class PlayerSlotCard extends StatelessWidget {
  final String? playerName;
  final String? roleLabel;
  // final String? symbol;
  final String? avatarUrl;
  final bool isOwner;
  final VoidCallback? onKick;

  const PlayerSlotCard.filled({
    super.key,
    required String name,
    required String role,
    // required String this.symbol,
    this.avatarUrl,
    this.isOwner = false,
    this.onKick,
  }) : playerName = name,
       roleLabel = role;

  const PlayerSlotCard.empty({super.key})
    : playerName = null,
      roleLabel = null,
      // symbol = null,
      avatarUrl = null,
      isOwner = false,
      onKick = null;

  bool get _isEmpty => playerName == null;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return AspectRatio(
      //  haaaaa (IT works somehow) ????
      aspectRatio: (0.85) * (w * .0024),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.glassPanelSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isEmpty ? AppColors.glassBorder : AppColors.coreCyan,
            width: _isEmpty ? 1 : 1.5,
          ),
        ),
        child: _isEmpty ? _buildEmpty() : _buildFilled(),
      ),
    );
  }

  Widget _buildEmpty() {
    return Stack(
      children: [
        const CusScan(),
        Center(
          child: Column(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: AppColors.mutedCyan, width: 1.5),
                ),
                child: const Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.mutedCyan,
                  size: 20,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'SCANNING...',
                textAlign: .center,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.coreCyan,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'AWAITING PLAYER',
                textAlign: .center,
                style: AppTypography.caption.copyWith(
                  color: AppColors.lowContrastText,
                  fontStyle: .italic,
                ),
              ),
              // const SizedBox(height: 18),
              // Container(
              //   width: 28,
              //   height: 28,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: AppColors.ultraLowContrast,
              //       width: 1,
              //     ),
              //   ),
              //   child: Text(
              //     '0',
              //     style: AppTypography.labelSmall.copyWith(
              //       color: AppColors.lowContrastText,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilled() {
    return Padding(
      padding: const .all(16),
      child: Column(
        mainAxisSize: .min,
        children: [
          Stack(
            clipBehavior: .none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: AppColors.coreCyan, width: 2),
                ),
                child: ClipOval(
                  child: avatarUrl != null
                      ? Image.network(avatarUrl!, fit: .cover)
                      : Container(
                          color: AppColors.inputBackground,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.mutedCyan,
                            size: 32,
                          ),
                        ),
                ),
              ),
              // Positioned(
              //   bottom: -2,
              //   right: -2,
              //   child: Container(
              //     width: 24,
              //     height: 24,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: AppColors.deepSpaceDark,
              //       border: Border.all(color: AppColors.coreCyan, width: 1.5),
              //     ),
              //     child: Text(
              //       symbol ?? '',
              //       style: AppTypography.labelSmall.copyWith(
              //         color: AppColors.coreCyan,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              if (onKick != null)
                Positioned(
                  top: -2,
                  left: -2,
                  child: GestureDetector(
                    onTap: onKick,
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: .center,
                      decoration: const BoxDecoration(
                        shape: .circle,
                        color: AppColors.actionBlue,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            playerName!.toUpperCase(),
            style: AppTypography.h6.copyWith(color: AppColors.primaryText),
          ),
          const SizedBox(height: 4),
          Text(
            roleLabel!.toUpperCase(),
            textAlign: .center,
            style: AppTypography.caption.copyWith(color: AppColors.coreCyan),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: .center,
            children: .generate(
              3,
              (i) => Container(
                margin: const .symmetric(horizontal: 3),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: .circle,
                  color: AppColors.coreCyan,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
