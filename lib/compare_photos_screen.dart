import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'common_widgets.dart';
import 'cleanup_complete_screen.dart';

/// Details shown under each photo (demo data).
class _PhotoInfo {
  final String name;
  final String size;
  final String res;
  final String date;
  final String asset;
  final List<Color> colors;

  const _PhotoInfo({
    required this.name,
    required this.size,
    required this.res,
    required this.date,
    required this.asset,
    required this.colors,
  });
}

class ComparePhotosScreen extends StatefulWidget {
  /// Which set is shown first (1-based). The design shows "Set 2 of 12".
  final int initialSet;
  final int totalSets;

  /// Number of photos that will be removed, passed on to the final screen.
  final int removedCount;

  const ComparePhotosScreen({
    super.key,
    this.initialSet = 2,
    this.totalSets = 12,
    this.removedCount = 24,
  });

  @override
  State<ComparePhotosScreen> createState() => _ComparePhotosScreenState();
}

class _ComparePhotosScreenState extends State<ComparePhotosScreen> {
  static const _original = _PhotoInfo(
    name: 'IMG_2841.jpg',
    size: '5.1 MB',
    res: '4032 × 3024',
    date: 'Aug 24, 2026',
    asset: 'assets/images/garden1.jpg',
    colors: [Color(0xFF8A9B5A), Color(0xFFE9E3C8)],
  );

  static const _copy = _PhotoInfo(
    name: 'IMG_2841_edit.jpg',
    size: '4.2 MB',
    res: '3024 × 2268',
    date: 'Aug 24, 2026',
    asset: 'assets/images/garden2.jpg',
    colors: [Color(0xFF4F6B3A), Color(0xFFD9D5B8)],
  );

  late int _set = widget.initialSet;
  bool _keepOriginal = true;

  bool get _isLast => _set >= widget.totalSets;

  void _next() {
    if (_isLast) {
      // Remove every earlier screen except the first, so Back can't return
      // into a finished cleanup.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => CleanupCompleteScreen(removed: widget.removedCount),
        ),
        (route) => route.isFirst,
      );
    } else {
      setState(() {
        _set++;
        _keepOriginal = true;
      });
    }
  }

  void _zoom(_PhotoInfo p) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: InteractiveViewer(
          child: PhotoTile(
            asset: p.asset,
            colors: p.colors,
            height: 420,
            radius: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _header(context),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Choose the one to keep',
                      style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textGrey)),
                  _zoomChip(),
                ],
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _photoCard(
                            label: 'ORIGINAL',
                            info: _original,
                            keep: _keepOriginal,
                            onTap: () => setState(() => _keepOriginal = true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _photoCard(
                            label: 'COPY',
                            info: _copy,
                            keep: !_keepOriginal,
                            onTap: () => setState(() => _keepOriginal = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _insightStrip(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: 'Swap',
                      icon: Icons.swap_horiz,
                      onTap: () =>
                          setState(() => _keepOriginal = !_keepOriginal),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: _isLast ? 'Finish' : 'Next set',
                      icon: Icons.arrow_forward,
                      onTap: _next,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        CircleIconButton(
            icon: Icons.arrow_back, onTap: () => Navigator.pop(context)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Compare photos',
                  style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3)),
              Text('Set $_set of ${widget.totalSets} · 96% similar',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
        ),
        const CircleIconButton(icon: Icons.more_vert),
      ],
    );
  }

  Widget _zoomChip() {
    return GestureDetector(
      onTap: () => _zoom(_keepOriginal ? _original : _copy),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.open_in_full, size: 13, color: AppColors.primary),
            const SizedBox(width: 6),
            Text('Tap to zoom',
                style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary)),
          ],
        ),
      ),
    );
  }

  Widget _photoCard({
    required String label,
    required _PhotoInfo info,
    required bool keep,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: keep ? AppColors.primary : const Color(0xFFF1DCD6),
            width: keep ? 2 : 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label,
                      style: GoogleFonts.inter(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppColors.textGrey)),
                  _badge(keep),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 0.74,
              child: PhotoTile(
                asset: info.asset,
                colors: info.colors,
                radius: 18,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info.name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 11.5, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  _detailRow('SIZE', info.size),
                  _detailRow('RES', info.res),
                  _detailRow('DATE', info.date),
                  const SizedBox(height: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(bool keep) {
    final fg = keep ? AppColors.primary : const Color(0xFFC0392B);
    final bg = keep ? AppColors.primaryLight : const Color(0xFFF6D9D6);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(keep ? Icons.check : Icons.delete_outline, size: 11, color: fg),
          const SizedBox(width: 3),
          Text(keep ? 'KEEP' : 'DELETE',
              style: GoogleFonts.inter(
                  fontSize: 9.5, fontWeight: FontWeight.w700, color: fg)),
        ],
      ),
    );
  }

  Widget _detailRow(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k,
              style: GoogleFonts.inter(
                  fontSize: 9.5,
                  letterSpacing: 0.6,
                  color: AppColors.textMuted)),
          Text(v,
              style: GoogleFonts.inter(
                  fontSize: 10.5, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _insightStrip() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_outlined,
              size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _keepOriginal
                  ? 'The original is sharper and has 34% more resolution.'
                  : 'The copy is edited and has lower resolution than the original.',
              style: GoogleFonts.inter(
                  fontSize: 11.5, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
