import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'common_widgets.dart';
import 'choose_scan_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _logo(),
              const SizedBox(height: 28),
              _heroCard(),
              const SizedBox(height: 28),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 30,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                    color: AppColors.textDark,
                  ),
                  children: const [
                    TextSpan(text: 'A calmer camera\nroll, '),
                    TextSpan(
                      text: 'in a few taps.',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Find exact copies and look-alike photos privately\non your device. You choose what stays.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textGrey,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Get started',
                icon: Icons.arrow_forward,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChooseScanScreen()),
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  'Private by design · Nothing leaves your phone',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: AppColors.primary, shape: BoxShape.circle),
          child: Text('c.',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15)),
        ),
        const SizedBox(width: 8),
        Text('clarity.',
            style: GoogleFonts.inter(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 19,
                letterSpacing: -0.3)),
      ],
    );
  }

  Widget _heroCard() {
    return Center(
      child: SizedBox(
        width: 260,
        height: 246,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // hero image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  'assets/images/img01.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // matches pill
            Positioned(
              right: -4,
              bottom: -14,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle),
                      child: const Icon(Icons.check,
                          size: 13, color: AppColors.primary),
                    ),
                    const SizedBox(width: 8),
                    Text('2 matches found',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _polaroid(double angle, double opacity) {
    return Transform.rotate(
      angle: angle * math.pi / 1.2,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 112,
          height: 92,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const PhotoTile(
            asset: 'assets/images/coast.jpg',
            radius: 0,
            colors: [Color(0xFF7FA6A8), Color(0xFF3B6E6A), Color(0xFF8C8A5A)],
          ),
        ),
      ),
    );
  }
}
