import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'common_widgets.dart';
import 'results_screen.dart';

class ScanningScreen extends StatefulWidget {
  final int totalPhotos;
  const ScanningScreen({super.key, this.totalPhotos = 1828});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    // Demo only: simulates scan progress. Replace with real scan progress later.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..forward();
    _controller.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ResultsScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
      _paused ? _controller.stop() : _controller.forward();
    });
  }

  String _fmt(int n) => n.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final p = _controller.value;
              final done = (p * widget.totalPhotos).round();
              final secs = ((1 - p) * 40).ceil();
              final similarityDone = p >= 1;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Finding duplicates',
                                style: GoogleFonts.inter(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.3)),
                            Text('You can leave this screen',
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.textGrey)),
                          ],
                        ),
                      ),
                      const CircleIconButton(icon: Icons.more_vert),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: CustomPaint(
                        painter: _RingPainter(p),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${(p * 100).round()}%',
                                  style: GoogleFonts.inter(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -1.5)),
                              Text(
                                  '${_fmt(done)} of ${_fmt(widget.totalPhotos)} photos',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.textGrey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Center(
                    child: Text(
                      _paused
                          ? 'Scan paused'
                          : 'Comparing image details - this takes\nabout $secs seconds.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.textGrey),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _stepTile(
                    icon: Icons.check,
                    filled: true,
                    title: 'File-hash matching',
                    subtitle: '42 exact copies found',
                    status: 'DONE',
                    statusColor: AppColors.primary,
                  ),
                  const SizedBox(height: 12),
                  _stepTile(
                    icon: Icons.center_focus_strong_outlined,
                    filled: false,
                    title: 'Visual similarity',
                    subtitle: 'Looking for edited and resized copies',
                    status: similarityDone ? 'DONE' : 'ANALYZING',
                    statusColor:
                        similarityDone ? AppColors.primary : AppColors.amber,
                  ),
                  const SizedBox(height: 12),
                  _currentFile(),
                  const Spacer(),
                  GestureDetector(
                    onTap: _togglePause,
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(40),
                        border:
                            Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              _paused
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause,
                              color: AppColors.primary,
                              size: 20),
                          const SizedBox(width: 10),
                          Text(_paused ? 'Resume scan' : 'Pause scan',
                              style: GoogleFonts.inter(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _stepTile({
    required IconData icon,
    required bool filled,
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: filled ? AppColors.primary : AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                size: 20, color: filled ? Colors.white : AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 14.5, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 11.5, color: AppColors.textGrey)),
              ],
            ),
          ),
          Text(status,
              style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: statusColor)),
        ],
      ),
    );
  }

  Widget _currentFile() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          const PhotoTile(
            asset: 'assets/images/mountain.jpg',
            width: 42,
            height: 42,
            radius: 8,
            colors: [Color(0xFF5B7F8F), Color(0xFF2F4F4F)],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('IMG_20260814_071226.jpg',
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w500)),
              Text('Camera · 4.8 MB',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: AppColors.textGrey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const stroke = 12.0;
    final radius = (size.width - stroke) / 2;

    // faint leaf-circle decoration behind the ring
    final deco = Paint()
      ..color = AppColors.border.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center.translate(70, 20), 70, deco);

    final track = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawCircle(center, radius, track);

    final arc = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
