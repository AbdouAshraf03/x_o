import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  final String hintText;

  final TextEditingController? controller;

  final IconData? icon;

  final bool obscureText;

  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return _ObscurableField(
      label: label,
      hintText: hintText,
      controller: controller,
      icon: icon,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      textInputAction: textInputAction,
    );
  }
}

class _ObscurableField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  const _ObscurableField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.obscureText,
    required this.keyboardType,
    required this.validator,
    required this.onChanged,
    required this.textInputAction,
  });

  @override
  State<_ObscurableField> createState() => _ObscurableFieldState();
}

class _ObscurableFieldState extends State<_ObscurableField> {
  late bool _isObscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: AppTypography.overline.copyWith(color: AppColors.mutedCyan),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.primaryText,
          ),

          decoration: InputDecoration(
            hintText: widget.hintText.toUpperCase(),
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: AppColors.mutedCyan, size: 20)
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.mutedCyan,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
