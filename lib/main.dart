import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/app_config.dart';
import 'screens/home_screen.dart';

/// Entry point aplikasi.
///
/// Memuat konfigurasi dari file `.env` sebelum menjalankan aplikasi,
/// lalu memberi peringatan di log jika konfigurasi tidak lengkap.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Memuat file .env sebelum aplikasi dijalankan
  await dotenv.load(fileName: ".env");

  if (!AppConfig.isConfigured()) {
    debugPrint('Peringatan: Konfigurasi .env tidak lengkap.');
  }

  runApp(const MyApp());
}

/// Widget root aplikasi.
///
/// Mengatur tema Material 3 dan menjadikan [HomeScreen] sebagai
/// halaman awal.
class MyApp extends StatelessWidget {
  /// Membuat widget root [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPL & Keamanan Kode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
