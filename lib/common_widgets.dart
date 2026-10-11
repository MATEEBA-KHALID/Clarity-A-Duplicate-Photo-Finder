import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

/// Full-width dark green pill button used on every screen.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small white circular icon button (back, shield, more).
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const CircleIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.border, width: 0.8),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 20, color: AppColors.textDark),
        ),
      ),
    );
  }
}

/// Photo placeholder. Loads [asset] if it exists, otherwise shows a gradient.
class PhotoTile extends StatelessWidget {
  final String? asset;
  final List<Color> colors;
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;

  const PhotoTile({
    super.key,
    this.asset,
    required this.colors,
    this.width,
    this.height,
    this.radius = 12,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (asset != null)
              Image.asset(asset!, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => fallback)
            else
              fallback,
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
