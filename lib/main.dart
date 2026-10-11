import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'welcome_screen.dart';
import 'app_theme.dart';

void main() {
<<<<<<< Updated upstream
=======
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
>>>>>>> Stashed changes
  runApp(const ClarityApp());
}

class ClarityApp extends StatelessWidget {
  const ClarityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

// ===================== SCREEN 1 =====================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              // App Icon
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B4332),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.description,
                  color: Colors.white,
                  size: 34,
                ),
              ),

              const SizedBox(height: 24),

              // App Name
              const Text(
                'clarity.',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
              ),

              const SizedBox(height: 12),

              // Tagline
              const Text(
                'Find and remove duplicate photos. Make\nroom for what matters.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 32),

              // Feature boxes
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'File hash matching',
                  style: TextStyle(fontSize: 13, color: Color(0xFF1B4332)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Visual similarity',
                  style: TextStyle(fontSize: 13, color: Color(0xFF1B4332)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Side-by-side compare',
                  style: TextStyle(fontSize: 13, color: Color(0xFF1B4332)),
                ),
              ),

              const Spacer(),

              // Get Started Button → goes to Screen 2
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectPhotosScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Get Started  →',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Restore previous session',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== SCREEN 2 =====================
class SelectPhotosScreen extends StatefulWidget {
  const SelectPhotosScreen({super.key});

  @override
  State<SelectPhotosScreen> createState() => _SelectPhotosScreenState();
}

class _SelectPhotosScreenState extends State<SelectPhotosScreen> {
  // This list controls which folders are selected
  // true = selected, false = not selected
  List<bool> isSelected = [
    true,  // Camera Roll
    false, // Downloads
    false, // Screenshots
    false, // WhatsApp Images
    false, // Vacation 2024
    false, // Documents
    false, // Profile Photos
    false, // Shared with Me
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1B4332)),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Select photos to scan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                ],
              ),
            ),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose the folders or albums you want\nClarity to analyze.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 16),

            // List of folders
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // 1. Camera Roll
                    folderItem(
                      icon: Icons.camera_alt_outlined,
                      title: 'Camera Roll',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[0],
                      onTap: () {
                        setState(() {
                          isSelected[0] = !isSelected[0];
                        });
                      },
                    ),
                    // 2. Downloads
                    folderItem(
                      icon: Icons.download_outlined,
                      title: 'Downloads',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[1],
                      onTap: () {
                        setState(() {
                          isSelected[1] = !isSelected[1];
                        });
                      },
                    ),
                    // 3. Screenshots
                    folderItem(
                      icon: Icons.image_outlined,
                      title: 'Screenshots',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[2],
                      onTap: () {
                        setState(() {
                          isSelected[2] = !isSelected[2];
                        });
                      },
                    ),
                    // 4. WhatsApp Images
                    folderItem(
                      icon: Icons.chat_bubble_outline,
                      title: 'WhatsApp Images',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[3],
                      onTap: () {
                        setState(() {
                          isSelected[3] = !isSelected[3];
                        });
                      },
                    ),
                    // 5. Vacation 2024
                    folderItem(
                      icon: Icons.beach_access_outlined,
                      title: 'Vacation 2024',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[4],
                      onTap: () {
                        setState(() {
                          isSelected[4] = !isSelected[4];
                        });
                      },
                    ),
                    // 6. Documents
                    folderItem(
                      icon: Icons.description_outlined,
                      title: 'Documents',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[5],
                      onTap: () {
                        setState(() {
                          isSelected[5] = !isSelected[5];
                        });
                      },
                    ),
                    // 7. Profile Photos
                    folderItem(
                      icon: Icons.person_outline,
                      title: 'Profile Photos',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[6],
                      onTap: () {
                        setState(() {
                          isSelected[6] = !isSelected[6];
                        });
                      },
                    ),
                    // 8. Shared with Me
                    folderItem(
                      icon: Icons.share_outlined,
                      title: 'Shared with Me',
                      subtitle: 'total pics, memory size',
                      isSelected: isSelected[7],
                      onTap: () {
                        setState(() {
                          isSelected[7] = !isSelected[7];
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom summary + button (you can keep the old static version)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F0E9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B4332),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.folder, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1 folder selected · total photos to scan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          Text(
                            'Estimated scan time: ~n minutes',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B4332),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Start scan  →',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home, color: Color(0xFF1B4332)),
                      Text('Home', style: TextStyle(fontSize: 12, color: Color(0xFF1B4332))),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library_outlined, color: Colors.grey),
                      Text('Photos', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history, color: Colors.grey),
                      Text('History', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.settings_outlined, color: Colors.grey),
                      Text('Settings', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
=======
      title: 'Clarity',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const WelcomeScreen(),
>>>>>>> Stashed changes
    );
  }
}

Widget folderItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required bool isSelected,
  required VoidCallback onTap,   // ← new
}) {
  return GestureDetector(          // ← makes it tappable
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF1B4332), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B4332),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? const Color(0xFF1B4332) : Colors.grey,
            size: 26,
          ),
        ],
      ),
    ),
  );
}