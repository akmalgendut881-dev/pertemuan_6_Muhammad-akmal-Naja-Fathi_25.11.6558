import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Konfigurasi aplikasi yang dimuat dari file `.env`.
///
/// Class ini menyediakan akses terpusat ke konfigurasi seperti
/// base URL dan API key, sehingga tidak ada hardcoded credential
/// di dalam kode sumber.
class AppConfig {
  /// Base URL untuk API.
  ///
  /// Diambil dari environment variable `BASE_URL`.
  /// Mengembalikan string kosong jika tidak ditemukan.
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  /// API key untuk autentikasi.
  ///
  /// Diambil dari environment variable `API_KEY`.
  /// Nilai ini tidak boleh dicetak ke log.
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Batas waktu (timeout) request HTTP dalam detik.
  static const int timeoutSeconds = 10;

  /// Memeriksa apakah konfigurasi sudah lengkap.
  ///
  /// Mengembalikan `true` jika [baseUrl] dan [apiKey] tidak kosong.
  static bool isConfigured() {
    return baseUrl.isNotEmpty && apiKey.isNotEmpty;
  }
}
