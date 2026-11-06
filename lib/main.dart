import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'services/pref_service.dart';

void main() async {
  // Wajib dipanggil sebelum ada pemanggilan async/plugin di main()
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await PrefService.init();
  await prefs.increaseOpenCount();
  debugPrint('Isi key SharedPreferences: ${prefs.debugKeys}');
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.prefs});
  final PrefService prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Nilai awal langsung dibaca dari prefs yang sudah di-load di main()
  late final ValueNotifier<bool> _isDark =
      ValueNotifier(widget.prefs.isDarkMode);

  void _changeTheme(bool value) {
    _isDark.value = value;            // 1. Perbarui UI seketika
    widget.prefs.setDarkMode(value);  // 2. Simpan ke SharedPreferences
  }

  @override
  void dispose() {
    _isDark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDark,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'Kartu Profil Digital',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorSchemeSeed: Colors.indigo),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.dark,
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: ProfilePage(
            prefs: widget.prefs,
            isDark: isDark,
            onThemeChanged: _changeTheme,
          ),
        );
      },
    );
  }
}