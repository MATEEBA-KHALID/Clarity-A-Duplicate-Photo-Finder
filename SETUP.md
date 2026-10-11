# Clarity – Flutter UI setup

1. Create the project: `flutter create clarity`
2. Replace the `lib/` folder with the one provided.
3. Add the font package: `flutter pub add google_fonts`
4. (Optional) add your real photos to `assets/images/` and register them in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

Expected names: coast.jpg, mountain.jpg, beach1-3.jpg, garden1-3.jpg.
If an image is missing, a colored gradient placeholder is shown instead.

5. Run: `flutter run`

## Structure
lib/
  main.dart
  theme/app_theme.dart
  widgets/common_widgets.dart
  screens/
    welcome_screen.dart       -> ChooseScanScreen
    choose_scan_screen.dart   -> ScanningScreen
    scanning_screen.dart      -> ResultsScreen (auto when complete)
    results_screen.dart
