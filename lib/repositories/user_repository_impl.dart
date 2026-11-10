import '../models/user.dart';
import '../services/api_service.dart';
import 'user_repository.dart';

/// Implementasi konkret dari [UserRepository].
///
/// Class ini menggunakan [ApiService] untuk mengambil data dari API.
/// [ApiService] dapat di-inject lewat constructor sehingga mudah
/// diganti dengan mock saat pengujian.
class UserRepositoryImpl implements UserRepository {
  final ApiService _apiService;

  /// Membuat [UserRepositoryImpl].
  ///
  /// Jika [apiService] tidak diberikan, akan dibuat [ApiService] baru.
  UserRepositoryImpl({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  @override
  Future<List<User>> getUsers() async {
    return await _apiService.getUsers();
  }

  @override
  Future<User> getUserById(int id) async {
    return await _apiService.getUserById(id);
  }

  /// Menutup resource yang digunakan (HTTP client).
  void dispose() {
    _apiService.dispose();
  }
}
