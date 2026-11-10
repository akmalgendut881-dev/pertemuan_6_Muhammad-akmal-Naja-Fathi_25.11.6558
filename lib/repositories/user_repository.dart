import '../models/user.dart';

/// Abstraksi repository untuk mengelola data pengguna.
///
/// Interface ini mendefinisikan kontrak untuk operasi data pengguna.
/// UI hanya bergantung pada abstraksi ini (Dependency Inversion),
/// sedangkan implementasi konkretnya ada di `UserRepositoryImpl`.
abstract class UserRepository {
  /// Mengambil daftar semua pengguna.
  ///
  /// Mengembalikan [List] berisi [User] jika berhasil.
  /// Melempar [Exception] jika terjadi error.
  Future<List<User>> getUsers();

  /// Mengambil pengguna berdasarkan [id].
  ///
  /// Parameter [id] harus berupa integer positif.
  /// Mengembalikan [User] jika ditemukan.
  /// Melempar [Exception] jika terjadi error.
  Future<User> getUserById(int id);
}
