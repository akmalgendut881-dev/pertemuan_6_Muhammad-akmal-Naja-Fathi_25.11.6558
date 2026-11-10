import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service untuk menyimpan data sensitif secara terenkripsi.
///
/// Menggunakan `flutter_secure_storage` (EncryptedSharedPreferences di
/// Android dan Keychain di iOS) untuk menyimpan token dan PIN.
/// Nilai sensitif tidak pernah dicetak ke log.
class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _tokenKey = 'auth_token';
  static const String _pinKey = 'user_pin';

  /// Menyimpan [token] ke secure storage.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    debugPrint('Token berhasil disimpan'); // Logging aman (tanpa cetak nilai token)
  }

  /// Membaca token dari secure storage.
  ///
  /// Mengembalikan `null` jika token belum disimpan.
  Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    debugPrint(token != null ? 'Token ditemukan' : 'Token tidak ditemukan');
    return token;
  }

  /// Menghapus token dari secure storage.
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    debugPrint('Token berhasil dihapus');
  }

  /// Menyimpan [pin] ke secure storage.
  Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
    debugPrint('PIN berhasil disimpan');
  }

  /// Membaca PIN dari secure storage.
  ///
  /// Mengembalikan `null` jika PIN belum disimpan.
  Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  /// Menghapus semua data di secure storage.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
    debugPrint('Semua data berhasil dihapus');
  }

  /// Memeriksa apakah token sudah tersimpan.
  ///
  /// Mengembalikan `true` jika token ada di secure storage.
  Future<bool> hasToken() async {
    return await _storage.containsKey(key: _tokenKey);
  }
}
