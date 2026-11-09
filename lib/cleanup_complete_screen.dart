import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'common_widgets.dart';
import 'choose_scan_screen.dart';

class _HistoryItem {
  final String when;
  final String detail;
  final String saved;
  const _HistoryItem(this.when, this.detail, this.saved);
}

class CleanupCompleteScreen extends StatelessWidget {
  final int removed;
  final String recovered;

  const CleanupCompleteScreen({
    super.key,
    this.removed = 24,
    this.recovered = '1.84 GB',
  });

  @override
  Widget build(BuildContext context) {
    // Demo data: the first entry is the scan that just finished.
    final history = [
      _HistoryItem('Today, 9:42 AM', '1,828 photos · $removed removed', recovered),
      const _HistoryItem('Sep 12, 2026', '1,742 photos · 8 removed', '482 MB'),
      const _HistoryItem('Aug 28, 2026', '1,698 photos · 11 removed', '716 MB'),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // faint leaf-circle decoration, top right
          Positioned(
            top: 30,
            right: -70,
            child: IgnorePointer(
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.border.withOpacity(0.6), width: 1),
                ),
                child: Icon(Icons.eco_outlined,
                    size: 70, color: AppColors.border.withOpacity(0.8)),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 28),
                          Center(child: _successBadge()),
                          const SizedBox(height: 18),
                          Center(
                            child: Text('Cleanup complete',
                                style: GoogleFonts.inter(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.6)),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              '$removed duplicate photos moved to your device\ntrash.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  height: 1.45,
                                  color: AppColors.textGrey),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(child: _recoveredCard()),
                          const SizedBox(height: 20),
                          _trashNote(),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SCAN HISTORY',
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textMuted)),
                              Text('${history.length} scans',
                                  style: GoogleFonts.inter(
                                      fontSize: 11.5,
                                      color: AppColors.textGrey)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          for (int i = 0; i < history.length; i++)
                            _historyTile(history[i], latest: i == 0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    label: 'Scan again',
                    icon: Icons.refresh,
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ChooseScanScreen()),
                      // keep only the Welcome screen underneath
                          (route) => route.isFirst,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _successBadge() {
    return Container(
      width: 86,
      height: 86,
      decoration: const BoxDecoration(
          color: AppColors.primaryLight, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: AppColors.primary, shape: BoxShape.circle),
        child: const Icon(Icons.check, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _recoveredCard() {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border.withOpacity(0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(recovered,
              style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  color: AppColors.primary)),
          const SizedBox(height: 2),
          Text('SPACE RECOVERED',
              style: GoogleFonts.inter(
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _trashNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.beigeTile,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 17, color: AppColors.textGrey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Items stay in Trash for 30 days. You can restore them anytime.',
              style: GoogleFonts.inter(
                  fontSize: 11.5, height: 1.4, color: AppColors.textGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyTile(_HistoryItem item, {required bool latest}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: latest ? AppColors.primaryLight : AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: latest ? AppColors.primary : AppColors.beigeTile,
              shape: BoxShape.circle,
            ),
            child: Icon(latest ? Icons.check : Icons.history,
                size: 18, color: latest ? Colors.white : AppColors.textGrey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.when,
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(item.detail,
                    style: GoogleFonts.inter(
                        fontSize: 11, color: AppColors.textGrey)),
              ],
            ),
          ),
          Text(item.saved,
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
        ],
      ),
    );
  }
}
