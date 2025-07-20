// lib/presentation/widgets/common/solo_button.dart
import 'package:flutter/material.dart';

class SoloButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final List<Color>? gradient;
  final double height;
  final double borderRadius;
  final bool isOutlined;
  final bool isLoading;

  const SoloButton({
    Key? key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.gradient,
    this.height = 48,
    this.borderRadius = 12,
    this.isOutlined = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          height: height,
          decoration: BoxDecoration(
            gradient:
                isOutlined
                    ? null
                    : LinearGradient(
                      colors:
                          gradient ??
                          [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
            borderRadius: BorderRadius.circular(borderRadius),
            border:
                isOutlined
                    ? Border.all(color: Theme.of(context).colorScheme.primary)
                    : null,
          ),
          child: Center(
            child:
                isLoading
                    ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isOutlined
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color:
                                isOutlined
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        if (icon != null) ...[
                          const SizedBox(width: 8),
                          Icon(
                            icon,
                            color:
                                isOutlined
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                            size: 18,
                          ),
                        ],
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
