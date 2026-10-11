import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'common_widgets.dart';

class _DuplicateSet {
  final String title;
  final String subtitle;
  final String badge;
  final bool exact;
  final List<String> sizes;
  final List<List<Color>> colors;
  final List<String?> assets;
  final List<bool> selected;

  _DuplicateSet({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.exact,
    required this.sizes,
    required this.colors,
    required this.assets,
    required this.selected,
  });
}

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int _filter = 0; // 0 all, 1 exact, 2 similar

  // Selected items in the other (not shown) sets, for the demo count.
  static const int _otherSelected = 20;

  final List<_DuplicateSet> _sets = [
    _DuplicateSet(
      title: 'Set 01',
      subtitle: '3 beach photos · 18.4 MB',
      badge: 'Exact',
      exact: true,
      sizes: ['6.2 MB', '6.1 MB', '6.1 MB'],
      assets: [
        'assets/images/beach1.jpg',
        'assets/images/beach2.jpg',
        'assets/images/beach3.jpg'
      ],
      colors: [
        [Color(0xFF5E7A86), Color(0xFFC9B79A)],
        [Color(0xFF5E7A86), Color(0xFFC9B79A)],
        [Color(0xFF5E7A86), Color(0xFFC9B79A)],
      ],
      selected: [false, true, true],
    ),
    _DuplicateSet(
      title: 'Set 02',
      subtitle: '3 garden photos · 13.7 MB',
      badge: '96% similar',
      exact: false,
      sizes: ['5.1 MB', '4.4 MB', '4.2 MB'],
      assets: [
        'assets/images/garden1.jpg',
        'assets/images/garden2.jpg',
        'assets/images/garden3.jpg'
      ],
      colors: [
        [Color(0xFF6E8B4E), Color(0xFFE8E4D4)],
        [Color(0xFF6E8B4E), Color(0xFFE8E4D4)],
        [Color(0xFF6E8B4E), Color(0xFFE8E4D4)],
      ],
      selected: [false, true, true],
    ),
  ];

  int get _selectedCount =>
      _otherSelected +
      _sets.fold(0, (s, set) => s + set.selected.where((e) => e).length);

  List<_DuplicateSet> get _visible {
    if (_filter == 1) return _sets.where((s) => s.exact).toList();
    if (_filter == 2) return _sets.where((s) => !s.exact).toList();
    return _sets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 110),
                children: [
                  const SizedBox(height: 16),
                  _header(),
                  const SizedBox(height: 20),
                  _summaryCard(),
                  const SizedBox(height: 16),
                  _filters(),
                  const SizedBox(height: 16),
                  for (final s in _visible) _setCard(s),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(
                    label: 'Review $_selectedCount selected',
                    icon: Icons.arrow_forward,
                    onTap: () {
                      // TODO: navigate to the review / delete confirmation screen
                    },
                  ),
                  const SizedBox(height: 10),
                  Text('Best-quality photo kept in every set',
                      style: GoogleFonts.inter(
                          fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your results',
                  style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3)),
              Text('12 duplicate sets',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
        ),
        const CircleIconButton(icon: Icons.more_vert),
      ],
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle),
            child: const Icon(Icons.auto_awesome_outlined,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1.84 GB recoverable',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text('38 duplicates across 12 sets',
                  style: GoogleFonts.inter(
                      color: Colors.white70, fontSize: 11.5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    final labels = ['All sets · 12', 'Exact · 7', 'Similar · 5'];
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _filter = i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _filter == i ? AppColors.primaryLight : AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _filter == i
                        ? AppColors.primary.withOpacity(0.4)
                        : AppColors.border,
                  ),
                ),
                child: Text(labels[i],
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight:
                            _filter == i ? FontWeight.w700 : FontWeight.w500,
                        color: _filter == i
                            ? AppColors.primary
                            : AppColors.textGrey)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _setCard(_DuplicateSet s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.title,
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(s.subtitle,
                        style: GoogleFonts.inter(
                            fontSize: 11.5, color: AppColors.textGrey)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(s.badge,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (int i = 0; i < 3; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(child: _thumb(s, i)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _thumb(_DuplicateSet s, int i) {
    final selected = s.selected[i];
    return GestureDetector(
      onTap: () => setState(() => s.selected[i] = !selected),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PhotoTile(
              asset: s.assets[i],
              colors: s.colors[i],
              radius: 12,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : Colors.white.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: selected
                        ? const Icon(Icons.check,
                            size: 14, color: Colors.white)
                        : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(s.sizes[i],
              style: GoogleFonts.inter(
                  fontSize: 11, color: AppColors.textGrey)),
        ],
      ),
    );
  }
}
