import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import 'status_chip.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final String hostName;
  final IconData icon;
  final bool isOpen;
  final int occupied;
  final int capacity;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.roomName,
    required this.hostName,
    required this.icon,
    required this.isOpen,
    required this.occupied,
    required this.capacity,
    this.onTap,
  });

  bool get _isFull => occupied >= capacity;

  @override
  Widget build(BuildContext context) {
    final disabled = !isOpen || _isFull;

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.glassPanelSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: disabled ? AppColors.lowContrastText : AppColors.coreCyan,
              width: 3,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: disabled ? null : onTap,
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
                    child: Icon(
                      icon,
                      color: disabled
                          ? AppColors.mutedPlaceholder
                          : AppColors.coreCyan,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomName.toUpperCase(),
                          style: AppTypography.h6.copyWith(
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Host: $hostName',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.mutedCyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StatusChip(
                        label: _isFull ? 'Full' : 'Open',
                        isActive: !_isFull,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Occupancy: $occupied/$capacity',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.lowContrastText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
