import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'common_widgets.dart';
import 'scanning_screen.dart';

class _Folder {
  final String name;
  final IconData icon;
  final int photos;
  final String size;
  bool selected;

  _Folder(this.name, this.icon, this.photos, this.size, this.selected);
}

class ChooseScanScreen extends StatefulWidget {
  const ChooseScanScreen({super.key});

  @override
  State<ChooseScanScreen> createState() => _ChooseScanScreenState();
}

class _ChooseScanScreenState extends State<ChooseScanScreen> {
  final List<_Folder> _folders = [
    _Folder('Camera', Icons.photo_camera_outlined, 1284, '6.8 GB', true),
    _Folder('Screenshots', Icons.smartphone_outlined, 426, '1.2 GB', true),
    _Folder('Downloads', Icons.file_download_outlined, 118, '684 MB', true),
    _Folder('Messaging', Icons.chat_bubble_outline, 892, '2.1 GB', false),
  ];

  int get _selectedCount => _folders.where((f) => f.selected).length;
  int get _totalPhotos =>
      _folders.where((f) => f.selected).fold(0, (s, f) => s + f.photos);

  String _fmt(int n) => n.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');

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
              _accessCard(),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FOLDERS TO INCLUDE',
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted)),
                  Text('$_selectedCount selected',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 12),
              for (final f in _folders) _folderTile(f),
              const SizedBox(height: 4),
              _infoStrip(),
              const SizedBox(height: 16),
              Opacity(
                opacity: _totalPhotos == 0 ? 0.5 : 1,
                child: PrimaryButton(
                  label: 'Scan ${_fmt(_totalPhotos)} photos',
                  icon: Icons.center_focus_strong_outlined,
                  onTap: () {
                    if (_totalPhotos == 0) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ScanningScreen(totalPhotos: _totalPhotos),
                      ),
                    );
                  },
                ),
              ),
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
              Text('Choose what to scan',
                  style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3)),
              Text('Step 1 of 2',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
        ),
        const CircleIconButton(icon: Icons.shield_outlined),
      ],
    );
  }

  Widget _accessCard() {
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
            child: const Icon(Icons.photo_library_outlined,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Photos & videos access',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text('Only used to compare files on this\ndevice.',
                    style: GoogleFonts.inter(
                        color: Colors.white70, fontSize: 11, height: 1.35)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text('Allowed',
                style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _folderTile(_Folder f) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => f.selected = !f.selected),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: f.selected ? AppColors.border : const Color(0xFFE6E0D3),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: f.selected
                      ? AppColors.primaryLight
                      : AppColors.beigeTile,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(f.icon, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.name,
                        style: GoogleFonts.inter(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text('${_fmt(f.photos)} photos · ${f.size}',
                        style: GoogleFonts.inter(
                            fontSize: 11.5, color: AppColors.textGrey)),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: f.selected ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        f.selected ? AppColors.primary : const Color(0xFFD9D3C6),
                    width: 1.2,
                  ),
                ),
                child: f.selected
                    ? const Icon(Icons.check, size: 15, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_outlined,
              size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Text('Exact matches + visual similarity enabled',
              style: GoogleFonts.inter(
                  fontSize: 11.5, color: AppColors.primary)),
        ],
      ),
    );
  }
}
