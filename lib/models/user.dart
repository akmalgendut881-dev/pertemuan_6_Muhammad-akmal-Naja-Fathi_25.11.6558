/// Model data pengguna yang diambil dari API.
///
/// Merepresentasikan satu objek pengguna dari endpoint `/users`
/// (JSONPlaceholder).
class User {
  /// ID unik pengguna.
  final int id;

  /// Nama lengkap pengguna.
  final String name;

  /// Username pengguna.
  final String username;

  /// Alamat email pengguna.
  final String email;

  /// Nomor telepon pengguna.
  final String phone;

  /// Alamat website pengguna.
  final String website;

  /// Nama perusahaan tempat pengguna bekerja.
  final String companyName;

  /// Membuat objek [User] dengan semua field wajib diisi.
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
  });

  /// Membuat objek [User] dari data JSON hasil response API.
  ///
  /// Field yang tidak ada di [json] diisi nilai default
  /// (`0` untuk angka, string kosong untuk teks), sehingga
  /// aplikasi tidak crash jika data dari server tidak lengkap.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      companyName: json['company']?['name'] ?? '',
    );
  }

  /// Huruf pertama dari [name] dalam huruf kapital.
  ///
  /// Digunakan sebagai inisial pada avatar. Mengembalikan `?`
  /// jika [name] kosong.
  String get initial {
    if (name.isEmpty) return '?';
    return name[0].toUpperCase();
  }
}
