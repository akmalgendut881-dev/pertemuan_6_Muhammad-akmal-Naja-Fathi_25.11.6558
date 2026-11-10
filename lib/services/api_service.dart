import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/user.dart';

/// Service untuk komunikasi HTTP dengan REST API.
///
/// Class ini menangani semua request HTTP ke API, termasuk
/// penanganan error dan timeout. Base URL dan API key diambil dari
/// [AppConfig] (file `.env`), bukan di-hardcode.
class ApiService {
  final http.Client _client;
  final String _baseUrl;

  /// Membuat [ApiService].
  ///
  /// [client] dan [baseUrl] bersifat opsional sehingga dapat diganti
  /// (misalnya dengan mock client) saat pengujian. Jika tidak diberikan,
  /// dipakai `http.Client()` dan [AppConfig.baseUrl].
  ApiService({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? AppConfig.baseUrl;

  /// Mengambil daftar pengguna dari endpoint `/users`.
  ///
  /// Mengembalikan [List] berisi [User] jika berhasil (status 200).
  /// Melempar [Exception] dengan pesan yang ramah pengguna jika terjadi
  /// timeout, tidak ada koneksi, format data salah, atau status selain 200.
  Future<List<User>> getUsers() async {
    try {
      _logRequest('GET', '/users');
      final response = await _client
          .get(Uri.parse('$_baseUrl/users'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on FormatException {
      throw Exception('Format data tidak valid.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil satu pengguna berdasarkan [id] dari endpoint `/users/{id}`.
  ///
  /// Mengembalikan [User] jika ditemukan.
  /// Melempar [Exception] dengan pesan yang ramah pengguna jika gagal.
  Future<User> getUserById(int id) async {
    try {
      _logRequest('GET', '/users/$id');
      final response = await _client
          .get(Uri.parse('$_baseUrl/users/$id'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Membangun header untuk request HTTP.
  ///
  /// Menyertakan API key dari [AppConfig] (tidak di-hardcode).
  Map<String, String> _buildHeaders() {
    return {'Content-Type': 'application/json', 'X-API-Key': AppConfig.apiKey};
  }

  /// Mencatat request ke log secara aman (tanpa token/API key).
  void _logRequest(String method, String endpoint) {
    debugPrint('[$method] $endpoint');
  }

  /// Mencatat response ke log secara aman (hanya status code).
  void _logResponse(int statusCode) {
    debugPrint('Response status: $statusCode');
  }

  /// Menutup HTTP client untuk membebaskan resource.
  void dispose() {
    _client.close();
  }
}
