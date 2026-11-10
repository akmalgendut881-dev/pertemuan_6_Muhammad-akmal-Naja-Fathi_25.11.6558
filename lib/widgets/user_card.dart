import 'package:flutter/material.dart';

import '../models/user.dart';

/// Widget kartu untuk menampilkan ringkasan data satu pengguna.
///
/// Menampilkan avatar berisi inisial, nama, username, dan email.
/// Widget ini hanya bertugas menampilkan data (Single Responsibility),
/// tanpa logika pengambilan data.
class UserCard extends StatelessWidget {
  /// Data pengguna yang ditampilkan.
  final User user;

  /// Callback yang dipanggil saat kartu ditekan.
  ///
  /// Jika `null`, kartu tidak merespons ketukan.
  final VoidCallback? onTap;

  /// Membuat [UserCard] untuk [user] tertentu.
  const UserCard({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(
            user.initial,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('@${user.username}'),
            Text(
              user.email,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
